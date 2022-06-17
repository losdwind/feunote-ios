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
    case momentSynced
    case momentCreated(_ moment: Moment)
    case momentDeleted(_ moment: Moment)
    case todoSynced
    case todoCreated(_ tood: Todo)
    case todoDeleted(_ todo: Todo)
    case personSynced
    case personCreated(_ person: Person)
    case personDeleted(_ person: Person)
    case branchSynced
    case branchCreated(_ branch: Branch)
    case branchDeleted(_ branch: Branch)
}

protocol DataStoreServiceProtocol {
    var user: User? { get }
    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError> { get }

    func configure(_ sessionStatePublisher: Published<SessionState>.Publisher)
    
    // Todo
    func saveMoment(_ moment: Moment,
                  completion: @escaping DataStoreCallback<Moment>)
    func deleteMoment(_ moment: Moment,
                    completion: @escaping DataStoreCallback<Void>)
    // Todo
    func saveTodo(_ todo: Todo,
                  completion: @escaping DataStoreCallback<Todo>)
    func deleteTodo(_ todo: Todo,
                    completion: @escaping DataStoreCallback<Void>)
    
    // Person
    func savePerson(_ person: Person,
                  completion: @escaping DataStoreCallback<Person>)
    func deletePerson(_ person: Person,
                    completion: @escaping DataStoreCallback<Void>)
    
    // Branch
    func saveBranch(_ branch: Branch,
                  completion: @escaping DataStoreCallback<Branch>)
    func deleteBranch(_ branch: Branch,
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

    // accept a sessionstate publisher from auth service
    func configure(_ sessionStatePublisher: Published<SessionState>.Publisher) {
        listenToDataStoreHubEvents()
        listen(to: sessionStatePublisher)
    }

    func saveMoment(_ moment: Moment,
                  completion: @escaping DataStoreCallback<Moment>) {
        Amplify.DataStore.save(moment) {
            if case .success = $0 {
                self.dataStoreServiceEventsTopic.send(.momentCreated(moment))
            }
            completion($0)
        }
    }
    
    func deleteMoment(_ moment: Moment,
                    completion: @escaping DataStoreCallback<Void>) {
        Amplify.DataStore.delete(moment) {
            if case .success = $0 {
                self.dataStoreServiceEventsTopic.send(.momentDeleted(moment))
            }
            completion($0)
        }
    }
    
    
    func saveTodo(_ todo: Todo,
                  completion: @escaping DataStoreCallback<Todo>) {
        Amplify.DataStore.save(todo) {
            if case .success = $0 {
                self.dataStoreServiceEventsTopic.send(.todoCreated(todo))
            }
            completion($0)
        }
    }
    
    func deleteTodo(_ todo: Todo,
                    completion: @escaping DataStoreCallback<Void>) {
        Amplify.DataStore.delete(todo) {
            if case .success = $0 {
                self.dataStoreServiceEventsTopic.send(.todoDeleted(todo))
            }
            completion($0)
        }
    }
    
    func savePerson(_ person: Person,
                  completion: @escaping DataStoreCallback<Person>) {
        Amplify.DataStore.save(person) {
            if case .success = $0 {
                self.dataStoreServiceEventsTopic.send(.personCreated(person))
            }
            completion($0)
        }
    }
    
    func deletePerson(_ person: Person,
                    completion: @escaping DataStoreCallback<Void>) {
        Amplify.DataStore.delete(person) {
            if case .success = $0 {
                self.dataStoreServiceEventsTopic.send(.personDeleted(person))
            }
            completion($0)
        }
    }
    
    func saveBranch(_ branch: Branch,
                  completion: @escaping DataStoreCallback<Branch>) {
        Amplify.DataStore.save(branch) {
            if case .success = $0 {
                self.dataStoreServiceEventsTopic.send(.branchCreated(branch))
            }
            completion($0)
        }
    }
    
    func deleteBranch(_ branch: Branch,
                    completion: @escaping DataStoreCallback<Void>) {
        Amplify.DataStore.delete(branch) {
            if case .success = $0 {
                self.dataStoreServiceEventsTopic.send(.branchDeleted(branch))
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
    /// listen to session status and take action when session state changed by subscribe to the session state publisher
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

    /// listen to datastore events (mostly about data loses or data syncs), take action to get updated data when sync happens
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
            case Moment.modelName:
                dataStoreServiceEventsTopic.send(.momentSynced)
            case Todo.modelName:
                dataStoreServiceEventsTopic.send(.todoSynced)
            case Person.modelName:
                dataStoreServiceEventsTopic.send(.personSynced)
            case Branch.modelName:
                dataStoreServiceEventsTopic.send(.branchSynced)
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

        let user = User(id: "\(authUser.userId)", avatarURL: "https://picsum.photos/200", nickName: authUser.username)
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
