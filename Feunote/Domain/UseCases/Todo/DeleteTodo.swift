//
//  DeleteTodo.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

protocol DeleteTodoUseCaseProtocol {
    func execute(todo:Todo) async throws 
}



class DeleteTodoUseCase: DeleteTodoUseCaseProtocol{

    

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    
    func execute(todo:Todo) async throws {
        guard let user = dataStoreRepo.user else { return }
        try await manager.dataStoreRepo.deleteTodo(todo)
        
    }
    
    
    }
