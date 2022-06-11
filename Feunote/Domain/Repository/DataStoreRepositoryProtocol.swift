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
    
    func dataStorePublisher<M: Model>(for model: M.Type) -> AnyPublisher<MutationEvent, DataStoreError>

    // Query
    func query<M: Model>(_ model: M.Type,
                         where predicate: QueryPredicate?,
                         sort sortInput: QuerySortInput?,
                         paginate paginationInput: QueryPaginationInput?,
                         completion: DataStoreCallback<[M]>)
    func query<M: Model>(_ model: M.Type,
                         byId: String,
                         completion: DataStoreCallback<M?>)
    
    // User
    func saveUser(_ user: User,
                  completion: @escaping DataStoreCallback<User>)
    
    // Moment
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
}
