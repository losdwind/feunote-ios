//
//  DataStoreRepositoryImpl.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Foundation
import Amplify
import Combine

class DataStoreRepositoryImpl:DataStoreRepositoryProtocol{
    var user: User?
    
    private let dataStoreService:DataStoreServiceProtocol
    
    init(dataStoreService:DataStoreServiceProtocol){
        self.dataStoreService = dataStoreService
    }
    
    func dataStorePublisher<M>(for model: M.Type) -> AnyPublisher<MutationEvent, DataStoreError> where M : Model {
        dataStoreService.dataStorePublisher(for: model)
        
    }
    
    func query<M>(_ model: M.Type, where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?, completion: (DataStoreResult<[M]>) -> Void) where M : Model {
        dataStoreService.query(model, where: predicate, sort: sortInput, paginate: paginationInput, completion: completion)
    }
    
    func query<M>(_ model: M.Type, byId: String, completion: (DataStoreResult<M?>) -> Void) where M : Model {
        dataStoreService.query(model, byId: byId, completion: completion)
    }
    
    func saveUser(_ user: User, completion: @escaping DataStoreCallback<User>) {
        dataStoreService.saveUser(user, completion: completion)
    }
    
    func saveMoment(_ moment: Moment, completion: @escaping DataStoreCallback<Moment>) {
        dataStoreService.saveMoment(moment, completion: completion)
    }
    
    func deleteMoment(_ moment: Moment, completion: @escaping DataStoreCallback<Void>) {
        dataStoreService.deleteMoment(moment, completion: completion)
    }
    
    func saveTodo(_ todo: Todo, completion: @escaping DataStoreCallback<Todo>) {
        dataStoreService.saveTodo(todo, completion: completion)
    }
    
    func deleteTodo(_ todo: Todo, completion: @escaping DataStoreCallback<Void>) {
        dataStoreService.deleteTodo(todo, completion: completion)
    }
    
    func savePerson(_ person: Person, completion: @escaping DataStoreCallback<Person>) {
        dataStoreService.savePerson(person, completion: completion)
    }
    
    func deletePerson(_ person: Person, completion: @escaping DataStoreCallback<Void>) {
        dataStoreService.deletePerson(person, completion: completion)
    }
    
    func saveBranch(_ branch: Branch, completion: @escaping DataStoreCallback<Branch>) {
        dataStoreService.saveBranch(branch, completion: completion)
    }
    
    func deleteBranch(_ branch: Branch, completion: @escaping DataStoreCallback<Void>) {
        dataStoreService.deleteBranch(branch, completion: completion)
    }
    
    
}
