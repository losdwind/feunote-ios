//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import Amplify
import AmplifyPlugins
import Foundation
import Combine

enum DataStoreServiceEvent {
    case userSynced(_ user: User)
    case userUpdated(_ user: User)
    case postSynced
    case postCreated(_ post: Post)
    case postDeleted(_ post: Post)
}

protocol DataStoreServiceProtocol {
    var user: User? { get }
    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError> { get }

    func configure(_ sessionState: Published<SessionState>.Publisher)
    func savePost(_ post: Post,
                  completion: @escaping DataStoreCallback<Post>)
    func deletePost(_ post: Post,
                    completion: @escaping DataStoreCallback<Void>)
    func saveUser(_ user: User,
                  completion: @escaping DataStoreCallback<User>)
    func query<M: Model>(_ model: M.Type,
                         where predicate: QueryPredicate?,
                         sort sortInput: QuerySortInput?,
                         paginate paginationInput: QueryPaginationInput?,
                         completion: DataStoreCallback<[M]>)
    func query<M: Model>(_ model: M.Type,
                         byId: String,
                         completion: DataStoreCallback<M?>)
    func dataStorePublisher<M: Model>(for model: M.Type) -> AnyPublisher<MutationEvent, DataStoreError>
}

class AmplifyDataStoreServiceManager: DataStoreServiceProtocol {
    private var authUser: AuthUser?
    private var dataStoreServiceEventsTopic: PassthroughSubject<DataStoreServiceEvent, DataStoreError>

    var user: User?
    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError> {
        return dataStoreServiceEventsTopic.eraseToAnyPublisher()
    }
    private var subscribers = Set<AnyCancellable>()

    init() {
        self.dataStoreServiceEventsTopic = PassthroughSubject<DataStoreServiceEvent, DataStoreError>()
    }

    func configure(_ sessionState: Published<SessionState>.Publisher) {
        listenToDataStoreHubEvents()
        listen(to: sessionState)
    }

    func savePost(_ post: Post,
                  completion: @escaping DataStoreCallback<Post>) {
        Amplify.DataStore.save(post) {
            if case .success = $0 {
                self.dataStoreServiceEventsTopic.send(.postCreated(post))
            }
            completion($0)
        }
    }

    func saveUser(_ user: User,
                  completion: @escaping DataStoreCallback<User>) {
        Amplify.DataStore.save(user) {
            if case .success = $0 {
                self.dataStoreServiceEventsTopic.send(.userUpdated(user))
            }
            completion($0)
        }
    }

    func query<M: Model>(_ model: M.Type,
                         where predicate: QueryPredicate? = nil,
                         sort sortInput: QuerySortInput? = nil,
                         paginate paginationInput: QueryPaginationInput? = nil,
                         completion: DataStoreCallback<[M]>) {
        Amplify.DataStore.query(model,
                                where: predicate,
                                sort: sortInput,
                                paginate: paginationInput) {
            completion($0)
        }
    }

    func query<M: Model>(_ model: M.Type,
                         byId id: String,
                         completion: DataStoreCallback<M?>) {
        Amplify.DataStore.query(model, byId: id) {
            completion($0)
        }
    }

    func deletePost(_ post: Post,
                    completion: @escaping DataStoreCallback<Void>) {
        Amplify.DataStore.delete(post) {
            if case .success = $0 {
                self.dataStoreServiceEventsTopic.send(.postDeleted(post))
            }
            completion($0)
        }
    }

    func dataStorePublisher<M: Model>(for model: M.Type) -> AnyPublisher<MutationEvent, DataStoreError> {
        Amplify.DataStore.publisher(for: model)
    }

    private func start() {
        Amplify.DataStore.start { _ in }
    }

    private func clear() {
        Amplify.DataStore.clear { _ in }
    }
}

extension AmplifyDataStoreServiceManager {
    private func listen(to sessionState: Published<SessionState>.Publisher?) {
        sessionState?
            .receive(on: DispatchQueue.main)
            .sink { state in
                switch state {
                case .signedOut:
                    self.clear()
                    self.user = nil
                    self.authUser = nil
                case .signedIn(let authUser):
                    self.authUser = authUser
                    self.start()
                }
            }
            .store(in: &subscribers)
    }

    private func listenToDataStoreHubEvents() {
        Amplify.Hub.publisher(for: .dataStore)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: hubEventsHandler(payload:))
            .store(in: &subscribers)
    }

    private func hubEventsHandler(payload: HubPayload) {
        switch payload.eventName {
        case HubPayload.EventName.DataStore.modelSynced:
            guard let modelSyncedEvent = payload.data as? ModelSyncedEvent else {
                Amplify.log.error(
                    """
                    Failed to case payload of type '\(type(of: payload.data))' \
                    to ModelSyncedEvent. This should not happen!
                    """
                )
                return
            }
            switch modelSyncedEvent.modelName {
            case User.modelName:
                getUser()
            case Post.modelName:
                dataStoreServiceEventsTopic.send(.postSynced)
            default:
                return
            }
        default:
            return
        }
    }

    private func getUser() {
        guard let userId = authUser?.userId else {
            return
        }

        query(User.self, byId: userId) {
            switch $0 {
            case .success(let user):
                guard let user = user else {
                    self.createUser()
                    return
                }
                self.user = user
                self.dataStoreServiceEventsTopic.send(.userSynced(user))
            case .failure(let error):
                Amplify.log.error("Error querying User - \(error.localizedDescription)")
            }
        }
    }

    private func createUser() {
        guard let authUser = self.authUser else {
            return
        }

        let user = User(id: "\(authUser.userId)",
                        username: authUser.username,
                        profilePic: "emptyUserPic")
        saveUser(user) {
            switch $0 {
            case .success:
                self.user = user
                self.dataStoreServiceEventsTopic.send(.userSynced(user))
                Amplify.log.debug("Successfully creating User for \(authUser.username)")
            case .failure(let error):
                self.dataStoreServiceEventsTopic.send(completion: .failure(error))
                Amplify.log.error("Error creating User for \(authUser.username) - \(error.localizedDescription)")
            }
        }
    }
}
