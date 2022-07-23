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
    
    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError>? { get }
    func configure(_ sessionState: Published<SessionState>.Publisher)
    func dataStorePublisher<M: Model>(for model: M.Type) -> AnyPublisher<MutationEvent, DataStoreError>


    // Query
//    func query<M:Model>(_ model: M.Type, where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [M]
    
    func queryUsers(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [AmplifyUser]
    
    func queryCommits(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [AmplifyCommit]
    
    func queryBranches(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [AmplifyBranch]
    
    
    func queryUser(byID:String) async throws -> AmplifyUser
    func queryBranch(byID:String) async throws -> AmplifyBranch
    func queryCommit(byID:String) async throws -> AmplifyCommit


    
    // User
    func saveUser(_ user: AmplifyUser) async throws -> AmplifyUser
    
    
    // AmplifyBranch
    func saveBranch(_ branch: AmplifyBranch) async throws -> AmplifyBranch
    func deleteBranch(_ branchID: String) async throws
    
    // AmplifyCommit
    func saveCommit(_ commit:AmplifyCommit) async throws -> AmplifyCommit
    func deleteCommit(_ commitID:String) async throws
    
    // AmplifyAction
    func saveAction(_ action:AmplifyAction) async throws -> AmplifyAction
    func deleteAction(_ action: AmplifyAction) async throws
    func queryComments(_ branchID: String) async throws -> [AmplifyAction]
    func queryMessages(_ branchID: String) async throws -> [AmplifyAction]
    
    // Open Branch from Remote API
    func queryOpenBranch(field:String, location:String, status:String) async throws -> [AmplifyBranch]
    func queryOpenBranchByID(branchID:String) async throws -> AmplifyBranch

}
