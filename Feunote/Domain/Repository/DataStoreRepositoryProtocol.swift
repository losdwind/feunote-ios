//
//  DataStoreRepositoryProtocol.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Foundation
import Amplify
import Combine

protocol DataStoreRepositoryProtocol {
    
    var amplifyUser:AmplifyUser? { get }
    var feuUser:FeuUser? {get}
    
    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError>? { get }
    func configure(_ sessionState: Published<SessionState>.Publisher)
    func dataStorePublisher<M: Model>(for model: M.Type) -> AnyPublisher<MutationEvent, DataStoreError>


    // Query
//    func query<M:Model>(_ model: M.Type, where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [M]
    
    func queryUsers(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [FeuUser]
    
    func queryCommits(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [FeuCommit]
    
    func queryBranches(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [FeuBranch]
    
//    func query<M:Model>(_ model: M.Type, byId: String) async throws -> M
    
    func queryUser(byID:String) async throws -> FeuUser
    func queryBranch(byID:String) async throws -> FeuBranch
    func queryCommit(byID:String) async throws -> FeuCommit


    
    // User
    func saveUser(_ user: FeuUser) async throws -> AmplifyUser
    
    
    // AmplifyBranch
    func saveBranch(_ branch: FeuBranch) async throws -> AmplifyBranch
    func deleteBranch(_ branchID: String) async throws
    
    // AmplifyCommit
    func saveCommit(_ commit:FeuCommit) async throws -> AmplifyCommit
    func deleteCommit(_ commitID:String) async throws
}
