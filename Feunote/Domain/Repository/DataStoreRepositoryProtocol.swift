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
    var user:User? { get }
    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError> { get }
    func configure(_ sessionState: Published<SessionState>.Publisher)
    func dataStorePublisher<M: Model>(for model: M.Type) -> AnyPublisher<MutationEvent, DataStoreError>


    // Query
    func query<M:Model>(_ model: M.Type, where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [M]
    
    func query<M:Model>(_ model: M.Type, byId: String) async throws -> M
    
    // User
    func saveUser(_ user: User) async throws -> User
    
    // Moment
    func saveMoment(_ moment: Moment) async throws -> Moment
    
    func deleteMoment(_ moment: Moment) async throws
    
    // Todo
    func saveTodo(_ todo: Todo) async throws -> Todo
    func deleteTodo(_ todo: Todo) async throws
    
    // Person
    func savePerson(_ person: Person) async throws -> Person
    func deletePerson(_ person: Person) async throws
    
    // Branch
    func saveBranch(_ branch: Branch) async throws -> Branch
    func deleteBranch(_ branch: Branch) async throws
}
