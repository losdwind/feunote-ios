//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import Amplify
import AWSAPIPlugin
import AWSDataStorePlugin
import Combine
import Foundation

enum DataStoreServiceEvent {
    case userSynced(_ user: AmplifyUser)
    case userUpdated(_ user: AmplifyUser)

    case commitSynced
    case commitCreated(_ commit: AmplifyCommit)
    case commitDeleted(_ commitID: String)

    case branchSynced
    case branchCreated(_ branch: AmplifyBranch)
    case branchDeleted(_ branchID: String)

    case actionSynced
    case actionCreated(_ action: AmplifyAction)
    case actionDeleted(_ actionID: String)

}

protocol DataStoreServiceProtocol {
    var user: AmplifyUser? { get }
    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError> { get }

    func dataStorePublisher<M: Model>(for model: M.Type) -> AnyPublisher<MutationEvent, DataStoreError>

    func configure(_ sessionStatePublisher: Published<SessionState>.Publisher)

    // AmplifyCommit
    func saveCommit(_ commit: AmplifyCommit) async throws -> AmplifyCommit
    func deleteCommit(_ commitID: String) async throws

    // AmplifyBranch
    func saveBranch(_ branch: AmplifyBranch) async throws -> AmplifyBranch
    func deleteBranch(_ branchID: String) async throws

    // AmplifyUser
    func saveUser(_ user: AmplifyUser) async throws -> AmplifyUser

    func save<M: Model>(_ model: M, where predicate: QueryPredicate?) async throws -> M
    func delete<M: Model>(_ model: M, where predicate: QueryPredicate?) async throws
    func delete<M: Model>(_ model: M.Type, withId id: String,
                          where predicate: QueryPredicate?) async throws
    func query<M: Model>(_ model: M.Type,
                         where predicate: QueryPredicate?,
                         sort sortInput: QuerySortInput?,
                         paginate paginationInput: QueryPaginationInput?) async throws -> [M]
    func query<M: Model>(_ model: M.Type,
                         byId: String) async throws -> M?
    func observeQuery<M: Model>(_ model: M.Type,
                                where predicate: QueryPredicate?,
                                sort sortInput: QuerySortInput?,
                                paginate paginationInput: QueryPaginationInput?) -> AnyPublisher<DataStoreQuerySnapshot<M>, DataStoreError>
}

class AmplifyDataStoreService: DataStoreServiceProtocol {
    private var authUser: AuthUser?
    private var dataStoreServiceEventsTopic: PassthroughSubject<DataStoreServiceEvent, DataStoreError>

    var user: AmplifyUser?

    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError> {
        return dataStoreServiceEventsTopic.eraseToAnyPublisher()
    }

    private var cancellables = Set<AnyCancellable>()
    private var modelSubscription = Set<AnyCancellable>()

    init() {
        dataStoreServiceEventsTopic = PassthroughSubject<DataStoreServiceEvent, DataStoreError>()
    }

    func dataStorePublisher<M: Model>(for model: M.Type) -> AnyPublisher<MutationEvent, DataStoreError> {
        Amplify.DataStore.publisher(for: model)
    }
}

// MARK: - Session State

extension AmplifyDataStoreService {
    // accept a sessionstate publisher from auth service
    func configure(_ sessionStatePublisher: Published<SessionState>.Publisher) {
        listenToDataStoreHubEvents()
        listen(to: sessionStatePublisher)
    }

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
                    case let .signedIn(authUser):
                        self.authUser = authUser
                        self.start()
                }
            }
            .store(in: &cancellables)
    }

    /// listen to datastore events (mostly about data loses or data syncs), take action to get updated data when sync happens
    private func listenToDataStoreHubEvents() {
        Amplify.Hub.publisher(for: .dataStore)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: hubEventsHandler(payload:))
            .store(in: &cancellables)
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
                    case AmplifyUser.modelName:
                        getUser()
                    case AmplifyCommit.modelName:
                        dataStoreServiceEventsTopic.send(.commitSynced)
                    case AmplifyAction.modelName:
                        dataStoreServiceEventsTopic.send(.actionSynced)
                    case AmplifyBranch.modelName:
                        dataStoreServiceEventsTopic.send(.branchSynced)
                    default:
                        return
                }
            default:
                return
        }
    }

//    private func getUser() {
//        Task {
//            guard let userId = authUser?.userId else { return }
//
//            do {
//
//                guard let user = try await query(AmplifyUser.self, byId: userId) else { throw AppError.itemDoNotExist }
//                print("get the user with id :\(user.id), email: \(String(describing: user.email))")
//                self.user = user
//                self.dataStoreServiceEventsTopic.send(.userSynced(user))
//            } catch {
//                Amplify.log.error("Error querying AmplifyUser - \(error.localizedDescription)")
////                self.createUser()
//            }
//
//
//        }
//    }

    private func getUser() {
        guard let userId = authUser?.userId else { return }
        self.observeQuery(AmplifyUser.self, where: (AmplifyUser.keys.id == userId)).sink {
            if case .failure(let error) = $0 {
                print("Got failed to fetch user \(error)")
            }} receiveValue: {
                querySnapshot in
                print("fetched current user: \(querySnapshot.items.count), isSynced: \(querySnapshot.isSynced)")
                DispatchQueue.main.async {
                    self.user = querySnapshot.items.first
                    print("get the user with id :\(self.user?.id), email: \(String(describing: self.user?.email))")
                    if self.user != nil {
                        self.dataStoreServiceEventsTopic.send(.userSynced(self.user!))
                    }
                }
            }
            .store(in:&cancellables)
    }

    private func fetchUserAttributes() async throws -> [AuthUserAttribute] {
        return try await withCheckedThrowingContinuation { continuation in

            Amplify.Auth.fetchUserAttributes().resultPublisher.sink { completion in
                switch completion {
                    case .finished:
                        print("fetched user attributes")
                    case let .failure(error):
                        print("Error: \(error)")
                        continuation.resume(throwing: error)
                }
            } receiveValue: { value in
                continuation.resume(returning: value)
            }
            .store(in: &cancellables)
        }
    }

    private func createUser() {
        guard let authUser = authUser else {
            return
        }

        Task {
            do {
                var user = AmplifyUser(id: authUser.userId, owner: nil, nickName: nil, username: authUser.username, avatarKey: nil, bio: nil, email: nil, realName: nil, gender: nil, birthday: nil, address: nil, phone: nil, job: nil, income: nil, marriage: nil, socialMedia: nil, interest: nil, bigFive: nil, wellbeingIndex: nil)

                let attributes = try await self.fetchUserAttributes()
                for attribute in attributes {
                    print(attribute)
                    if attribute.key.rawValue == "email" {
                        print("user's email is \(attribute.value)")
                        user.email = attribute.value
                    }
                }

                self.user = try await saveUser(user)
                self.dataStoreServiceEventsTopic.send(.userSynced(self.user!))
                Amplify.log.debug("Successfully creating User for \(authUser.username)")

            } catch {
                //                self.dataStoreServiceEventsTopic.send(completion: .failure(error as! DataStoreError))
                Amplify.log.error("Error creating User for \(authUser.username) - \(error.localizedDescription)")
            }
        }
    }

    private func start() {
        Amplify.DataStore.start { _ in }
    }

    private func clear() {
        Amplify.DataStore.clear { _ in }
    }
}

// MARK: - DataStore CRUD

extension AmplifyDataStoreService {
    func saveBranch(_ branch: AmplifyBranch) async throws -> AmplifyBranch {
        return try await withCheckedThrowingContinuation { continuation in

            Amplify.DataStore.save(branch)
                .sink(receiveCompletion: { completion in
                    switch completion {
                        case .finished:
                            self.dataStoreServiceEventsTopic.send(.branchCreated(branch))
                        case let .failure(error):
                            print("Error:Branch \(error)")
                            continuation.resume(throwing: error)
                    }

                }, receiveValue: {
                    branch in
                    continuation.resume(returning: branch)
                })
                .store(in: &cancellables)
        }
    }

    func deleteBranch(_ branchID: String) async throws {
        try await withCheckedThrowingContinuation { continuation in

            Amplify.DataStore.delete(AmplifyBranch.self, where: AmplifyBranch.keys.id == branchID)
                .sink(receiveCompletion: { completion in
                    switch completion {
                        case .finished:
                            self.dataStoreServiceEventsTopic.send(.branchDeleted(branchID))

                        case let .failure(error):
                            print("Error: \(error)")
                            continuation.resume(throwing: error)
                    }

                }, receiveValue: {
                    _ in
                    continuation.resume()
                })
                .store(in: &cancellables)
        }
    }

    func saveCommit(_ commit: AmplifyCommit) async throws -> AmplifyCommit {
        print("activate saveCommit function")

        return try await withCheckedThrowingContinuation { continuation in

            Amplify.DataStore.save(commit, completion: { result in
                switch result {
                    case let .success(value):
                        self.dataStoreServiceEventsTopic.send(.commitCreated(commit))
                        continuation.resume(returning: value)
                    case let .failure(error):
                        print("Error: \(error)")
                        continuation.resume(throwing: error)
                }
            })
        }
    }

    func deleteCommit(_ commitID: String) async throws {
        try await withCheckedThrowingContinuation { continuation in

            Amplify.DataStore.delete(AmplifyCommit.self, where: AmplifyCommit.keys.id == commitID)
                .sink(receiveCompletion: { error in
                    switch error {
                        case .finished:
                            self.dataStoreServiceEventsTopic.send(.commitDeleted(commitID))

                        case let .failure(error):
                            print("Error: \(error)")
                            continuation.resume(throwing: error)
                    }

                }, receiveValue: {
                    _ in
                    continuation.resume()
                })
                .store(in: &cancellables)
        }
    }

    func saveUser(_ user: AmplifyUser) async throws -> AmplifyUser {
        return try await withCheckedThrowingContinuation { continuation in

            Amplify.DataStore.save(user)
                .sink(receiveCompletion: { completion in
                    switch completion {
                        case .finished:
                            self.dataStoreServiceEventsTopic.send(.userUpdated(user))
                        case let .failure(error):
                            print("Error:User \(error)")
                            continuation.resume(throwing: error)
                    }
                }, receiveValue: {
                    value in
                    continuation.resume(returning: value)
                })
                .store(in: &cancellables)
        }
    }

    func save<M: Model>(_ model: M, where predicate: QueryPredicate? = nil) async throws -> M {
        return try await withCheckedThrowingContinuation { continuation in
            Amplify.DataStore.save(model, where: predicate) {
                switch $0 {
                    case let .success(value):
                        print("\(model.modelName) saved!")
                        continuation.resume(returning: value)
                    case let .failure(error):
                        print("Error saving \(model.modelName) - \(error.localizedDescription)")
                        continuation.resume(throwing: error)
                }
            }
        }
    }

    func delete<M: Model>(_ model: M,
                          where predicate: QueryPredicate? = nil) async throws
    {
        try await withCheckedThrowingContinuation { continuation in
            Amplify.DataStore.delete(model, where: predicate) {
                switch $0 {
                    case .success:
                        print("\(model.modelName) deleted!")
                        continuation.resume()
                    case let .failure(error):
                        print("Error deleting \(model.modelName) - \(error.localizedDescription)")
                        continuation.resume(throwing: error)
                }
            }
        }
    }

    func delete<M: Model>(_ model: M.Type, withId id: String,
                          where predicate: QueryPredicate? = nil) async throws
    {
        try await withCheckedThrowingContinuation { continuation in
            Amplify.DataStore.delete(model, withId: id, where: predicate) {
                switch $0 {
                    case .success:
                        print("\(model.modelName) deleted!")
                        continuation.resume()
                    case let .failure(error):
                        print("Error deleting \(model.modelName) - \(error.localizedDescription)")
                        continuation.resume(throwing: error)
                }
            }
        }
    }

    func query<M: Model>(_ model: M.Type,
                         where predicate: QueryPredicate? = nil,
                         sort sortInput: QuerySortInput? = nil,
                         paginate paginationInput: QueryPaginationInput? = nil) async throws -> [M]
    {
        return try await withCheckedThrowingContinuation { continuation in
            Amplify.DataStore.query(model,
                                    where: predicate,
                                    sort: sortInput,
                                    paginate: paginationInput)
            {
                result in
                switch result {
                    case let .success(data):
                        continuation.resume(returning: data)
                    case let .failure(error):
                        continuation.resume(throwing: error)
                }
            }
        }
    }

    func query<M: Model>(_ model: M.Type,
                         byId id: String) async throws -> M?
    {
        return try await withCheckedThrowingContinuation { continuation in
            Amplify.DataStore.query(model, byId: id) {
                result in
                switch result {
                    case let .success(data):
                        continuation.resume(returning: data)
                    case let .failure(error):
                        continuation.resume(throwing: error)
                }
            }
        }
    }

    func observeQuery<M: Model>(_ model: M.Type, where predicate: QueryPredicate? = nil,
                                sort sortInput: QuerySortInput? = nil,
                                paginate _: QueryPaginationInput? = nil) -> AnyPublisher<DataStoreQuerySnapshot<M>, DataStoreError>
    {
        return Amplify.DataStore.observeQuery(
            for: model,
            where: predicate,
            sort: sortInput
        )
    }

    // Then, when you're finished observing, cancel the subscription
    func unsubscribeModel() {
        for sub in modelSubscription {
            sub.cancel()
        }
    }
}
