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
    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError>
    
    func configure(_ sessionStatePublisher: Published<SessionState>.Publisher) {
        dataStoreService.configure(sessionStatePublisher)
    }
    
    func dataStorePublisher<M:Model>(for model: M.Type) -> AnyPublisher<MutationEvent, DataStoreError> {
        dataStoreService.dataStorePublisher(for: model)
    }
    
    private let dataStoreService:DataStoreServiceProtocol
    
    init(dataStoreService:DataStoreServiceProtocol){
        self.dataStoreService = dataStoreService
    }
    
    var user: User? {
        dataStoreService.user
    }
    
    
    func query<M:Model>(_ model: M.Type, where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws-> [M]  {
        return try await withCheckedThrowingContinuation { continuation in
            dataStoreService.query(model, where: predicate, sort: sortInput, paginate: paginationInput){
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
    
    func query<M:Model>(_ model: M.Type, byId: String) async throws -> M {
        return try await withCheckedThrowingContinuation { continuation in
            dataStoreService.query(model, byId: byId){
                result in
                switch result {
                case .success(let data):
                    guard data != nil else { continuation.resume(throwing:AppError.failedToParseData)}
                    continuation.resume(returning: data!)
                case .failure(_):
                    continuation.resume(throwing:AppError.failedToRead)
                
            }
        }
        }
    }
    
    func saveUser(_ user: User) async throws -> User{
            return try await withCheckedThrowingContinuation { continuation in
                dataStoreService.saveUser(user) { result in
                    // depending on the content of result, we either resume with a value or an error
                    switch result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(_):
                        continuation.resume(throwing: AppError.failedToSave)
                    }
                }
            }

    }
    
    func saveMoment(_ moment: Moment) async throws -> Moment{
            return try await withCheckedThrowingContinuation { continuation in
                dataStoreService.saveMoment(moment) { result in
                    // depending on the content of result, we either resume with a value or an error
                    switch result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(_):
                        continuation.resume(throwing: AppError.failedToSave)
                    }
                }
            }
        }
    
    
    func deleteMoment(_ moment: Moment) async throws{
        return try await withCheckedThrowingContinuation { continuation in
            dataStoreService.deleteMoment(moment) { result in
                // depending on the content of result, we either resume with a value or an error
                switch result {
                case .success(_):
                    continuation.resume()
                case .failure(_):
                    continuation.resume(throwing: AppError.failedToDelete)
                }
            }
        }
    }
    
    func saveTodo(_ todo: Todo) async throws -> Todo{
        
        return try await withCheckedThrowingContinuation { continuation in
            dataStoreService.saveTodo(todo){ result in
                // depending on the content of result, we either resume with a value or an error
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(_):
                    continuation.resume(throwing: AppError.failedToSave)
                }
            }
        }
    }
    
    func deleteTodo(_ todo: Todo) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            dataStoreService.deleteTodo(todo) { result in
                // depending on the content of result, we either resume with a value or an error
                switch result {
                case .success(_):
                    continuation.resume()
                case .failure(_):
                    continuation.resume(throwing: AppError.failedToDelete)
                }
            }
        }
    }
    
    func savePerson(_ person: Person) async throws -> Person {
        return try await withCheckedThrowingContinuation { continuation in
            dataStoreService.savePerson(person){ result in
                // depending on the content of result, we either resume with a value or an error
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(_):
                    continuation.resume(throwing: AppError.failedToSave)
                }
            }
        }
    }
    
    func deletePerson(_ person: Person) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            dataStoreService.deletePerson(person) { result in
                // depending on the content of result, we either resume with a value or an error
                switch result {
                case .success(_):
                    continuation.resume()
                case .failure(_):
                    continuation.resume(throwing: AppError.failedToDelete)
                }
            }
        }
    }
    
    func saveBranch(_ branch: Branch) async throws -> Branch {
        return try await withCheckedThrowingContinuation { continuation in
            dataStoreService.saveBranch(branch){ result in
                // depending on the content of result, we either resume with a value or an error
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(_):
                    continuation.resume(throwing: AppError.failedToSave)
                }
            }
        }
    }
    
    func deleteBranch(_ branch: Branch) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            dataStoreService.deleteBranch(branch){ result in
                // depending on the content of result, we either resume with a value or an error
                switch result {
                case .success(_):
                    continuation.resume()
                case .failure(_):
                    continuation.resume(throwing: AppError.failedToDelete)
                }
            }
        }
    }
    
    
}
