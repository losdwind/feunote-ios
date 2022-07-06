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
    case userSynced(_ user: AmplifyUser)
    case userUpdated(_ user: AmplifyUser)
    
    
    case commitSynced
    case commitCreated(_ commitID: AmplifyCommit)
    case commitDeleted(_ commitID: String)
    
    case branchSynced
    case branchCreated(_ branch: AmplifyBranch)
    case branchDeleted(_ branchID: String)
    
    case actionSynced
    case actionCreated(_ action: AmplifyAction)
    case actionDeleted(_ actionID: String)
    
    case sensorSynced
    case sensorCreated(_ sensor: AmplifySensor)
    case sensorDeleted(_ snesorID: String)
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
    
    // Query
    func query<M: Model>(_ model: M.Type,
                         where predicate: QueryPredicate?,
                         sort sortInput: QuerySortInput?,
                         paginate paginationInput: QueryPaginationInput?) async throws -> [M]
    func query<M: Model>(_ model: M.Type,
                         byId: String) async throws -> M
    
}

class AmplifyDataStoreServiceManager: DataStoreServiceProtocol {
    
    func saveBranch(_ branch: AmplifyBranch) async throws -> AmplifyBranch{
        //        {
        //            if case .success = $0 {
        //                self.dataStoreServiceEventsTopic.send(.branchCreated(branch))
        //            }
        //            completion($0)
        //        }
        return try await withCheckedThrowingContinuation({ continuation in
            
            Amplify.DataStore.save(branch)
                .sink(receiveCompletion: { error in
                    switch error {
                        
                    case .finished:
                        self.dataStoreServiceEventsTopic.send(.branchCreated(branch))
                        
                    case .failure(let error):
                        print("Error: \(error)")
                        continuation.resume(throwing: AppError.failedToSave)
                    }
                    
                }, receiveValue: {
                    key in
                    continuation.resume(returning:key)
                })
                .store(in:&cancellables)
            
            
        })
    }
    
    func deleteBranch(_ branchID: String) async throws{
        
        try await withCheckedThrowingContinuation({ continuation in
            
            Amplify.DataStore.delete(AmplifyBranch.self, where: AmplifyBranch.keys.id == branchID)
                .sink(receiveCompletion: { error in
                    switch error {
                        
                    case .finished:
                        self.dataStoreServiceEventsTopic.send(.branchDeleted(branchID))
                        
                    case .failure(let error):
                        print("Error: \(error)")
                        continuation.resume(throwing: AppError.failedToDelete)
                    }
                    
                }, receiveValue: {
                    _ in
                    continuation.resume()
                })
                .store(in:&cancellables)
            
            
        })
        
    }
    
    func saveCommit(_ commit: AmplifyCommit) async throws -> AmplifyCommit {
        print("activate saveCommit function")
        
        //        return try await withCheckedThrowingContinuation({ continuation in
        //
        //
        //            Amplify.DataStore.save(commit)
        //                .sink(receiveCompletion: { error in
        //                    switch error {
        //
        //                    case .finished:
        //                        self.dataStoreServiceEventsTopic.send(.commitCreated(commit))
        //
        //                    case .failure(let error):
        //                        print("Error: \(error)")
        //                        continuation.resume(throwing: AppError.failedToSave)
        //                    }
        //
        //                }, receiveValue: {
        //                    value in
        //                    continuation.resume(returning:value)
        //                })
        //                .store(in:&cancellables)
        //
        //
        //        })
        //        let publisher = Amplify.DataStore.save(commit)
        //
        //        if let commit = try await publisher.values.first(where: { _ in true
        //        }){
        //            return commit
        //        } else {
        //            print("Error: failed to save commit to database in data store service manager")
        //            throw AppError.failedToSave
        //        }
        
        return try await withCheckedThrowingContinuation({ continuation in
            
            Amplify.DataStore.save(commit, completion: { result in
                switch result {
                case .success(let value):
                    self.dataStoreServiceEventsTopic.send(.commitCreated(commit))
                    continuation.resume(returning:value)
                case .failure(let error):
                    print("Error: \(error)")
                    continuation.resume(throwing: AppError.failedToSave)
                }
            })
            
            
            
        })
    }
    
    func deleteCommit(_ commitID: String) async throws {
        
        try await withCheckedThrowingContinuation({ continuation in
            
            Amplify.DataStore.delete(AmplifyCommit.self, where: AmplifyCommit.keys.id == commitID)
                .sink(receiveCompletion: { error in
                    switch error {
                        
                    case .finished:
                        self.dataStoreServiceEventsTopic.send(.commitDeleted(commitID))
                        
                    case .failure(let error):
                        print("Error: \(error)")
                        continuation.resume(throwing: AppError.failedToDelete)
                    }
                    
                }, receiveValue: {
                    _ in
                    continuation.resume()
                })
                .store(in:&cancellables)
            
            
        })
    }
    
    private var authUser: AuthUser?
    private var dataStoreServiceEventsTopic: PassthroughSubject<DataStoreServiceEvent, DataStoreError>
    
    var user: AmplifyUser?
    
    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError> {
        return dataStoreServiceEventsTopic.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.dataStoreServiceEventsTopic = PassthroughSubject<DataStoreServiceEvent, DataStoreError>()
    }
    
    // accept a sessionstate publisher from auth service
    func configure(_ sessionStatePublisher: Published<SessionState>.Publisher) {
        listenToDataStoreHubEvents()
        listen(to: sessionStatePublisher)
    }
    
    
    func saveUser(_ user: AmplifyUser) async throws -> AmplifyUser{
        
        return try await withCheckedThrowingContinuation({ continuation in
            
            Amplify.DataStore.save(user)
                .sink(receiveCompletion: { error in
                    switch error {
                        
                    case .finished:
                        self.dataStoreServiceEventsTopic.send(.userUpdated(user))
                        
                    case .failure(let error):
                        print("Error: \(error)")
                        continuation.resume(throwing: AppError.failedToSave)
                    }
                    
                }, receiveValue: {
                    value in
                    continuation.resume(returning:value)
                })
                .store(in:&cancellables)
            
            
        })
        
        
    }
    
    func query<M: Model>(_ model: M.Type,
                         where predicate: QueryPredicate? = nil,
                         sort sortInput: QuerySortInput? = nil,
                         paginate paginationInput: QueryPaginationInput? = nil) async throws -> [M] {
        
        return try await withCheckedThrowingContinuation { continuation in
            Amplify.DataStore.query(model,
                                    where: predicate,
                                    sort: sortInput,
                                    paginate: paginationInput){
                result in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(_):
                    continuation.resume(throwing: AppError.failedToRead)
                }
            }
            
        }
        
        
        
        
    }
    
    func query<M: Model>(_ model: M.Type,
                         byId id: String) async throws -> M{
        
        return try await withCheckedThrowingContinuation { continuation in
            Amplify.DataStore.query(model, byId: id){
                result in
                switch result {
                case .success(let data):
                    if data != nil {
                        continuation.resume(returning: data!)
                    } else {
                        continuation.resume(throwing:AppError.failedToParseData)}
                    
                case .failure(_):
                    continuation.resume(throwing:AppError.failedToRead)
                    
                }
            }
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
            case AmplifySensor.modelName:
                dataStoreServiceEventsTopic.send(.sensorSynced)
            case AmplifyBranch.modelName:
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
        
        Task {
            do {
                let user = try await query(AmplifyUser.self, byId: userId)
                print("User: \(user)")
                print("get the user with id :\(user.id), email: \(String(describing: user.email))")
                self.user = user
                self.dataStoreServiceEventsTopic.send(.userSynced(user))
            } catch(let error) {
                
                Amplify.log.error("Error querying AmplifyUser - \(error.localizedDescription)")
                self.createUser()
            }
        }
        
        
        //            switch $0 {
        //            case .success(let user):
        //                guard let user = user else {
        //                    self.createUser()
        //                    return
        //                }
        //                self.user = user
        //                self.dataStoreServiceEventsTopic.send(.userSynced(user))
        //            case .failure(let error):
        //                Amplify.log.error("Error querying AmplifyUser - \(error.localizedDescription)")
        //            }
    }
    
    private func fetchUserAttributes() async throws -> Array<AuthUserAttribute> {
        return try await withCheckedThrowingContinuation({ continuation in
            
            Amplify.Auth.fetchUserAttributes().resultPublisher.sink { completion in
                switch completion {
                    
                case .finished:
                    print("fetched user attributes")
                case .failure(let error):
                    print("Error: \(error)")
                    continuation.resume(throwing: AppError.failedToRead)
                }
            } receiveValue: { value in
                continuation.resume(returning: value)
            }
            .store(in: &cancellables)
        })
        
        
    }
    private func createUser() {
        guard let authUser = self.authUser else {
            return
        }
        
        Task {
            var user = AmplifyUser(id: authUser.userId, username: authUser.username, avatarKey: nil, nickName: nil, bio: "Empty Bio", email: nil, phone: nil, realName: nil, gender: nil, birthday: nil, address: nil, job: nil, income: nil, marriage: nil, socialMedia: nil, interest: nil)
            
            let attributes = try await self.fetchUserAttributes()
            for attribute in attributes {
                print(attribute)
                if (attribute.key.rawValue == "email") {
                    print("user's email is \(attribute.value)")
                    user.email = attribute.value
                }
            }
            self.user = try await saveUser(user)
        }
        
        //
        //            var user = AmplifyUser(username: authUser.userId)
        //
        //            Amplify.Auth.fetchUserAttributes() { result in
        //                switch result {
        //                case .success(let attributes):
        //                    print("User attributes - \(attributes)")
        //                    for attribute in attributes {
        //                        if (attribute.key.rawValue == "email") {
        //                            print("user's email is \(attribute.value)")
        //                            user.email = attribute.value
        //                            print("initialized the user with id :\(user.id), email: \(String(describing: user.email))")
        //                            self.saveUser(user)
        //                                .sink {
        //                                switch $0 {
        //
        //                                case .failure(let error):
        //                                    self.dataStoreServiceEventsTopic.send(completion: .failure(error))
        //                                    Amplify.log.error("Error creating AmplifyUser for \(authUser.username) - \(error.localizedDescription)")
        //                                    completion(false)
        //                                case .finished:
        //                                    self.dataStoreServiceEventsTopic.send(.userSynced(self.user!))
        //                                    Amplify.log.debug("Successfully creating AmplifyUser for \(authUser.username)")
        //                                    completion(true)
        //                                }
        //
        //                            } receiveValue: { user in
        //                                self.user = user
        //                            }.store(in: &self.cancellables)
        //                        }
        //                    }
        //                case .failure(let error):
        //                    print("Fetching user attributes failed with error \(error)")
        //                    completion(false)
        //                }
        //            }
        
        
        
        //        {
        //            switch $0 {
        //            case .success:
        //                self.user = user
        //                self.dataStoreServiceEventsTopic.send(.userSynced(user))
        //                Amplify.log.debug("Successfully creating AmplifyUser for \(authUser.username)")
        //            case .failure(let error):
        //                self.dataStoreServiceEventsTopic.send(completion: .failure(error))
        //                Amplify.log.error("Error creating AmplifyUser for \(authUser.username) - \(error.localizedDescription)")
        //            }
        //        }
    }
    
    
    
    
}

