//
//  SaveTodo.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

protocol SaveTodoUseCaseProtocol {
    func execute(existingTodo:Todo?, title:String, description:String?, start:Date?, end:Date?, completion:Bool, reminder:Bool?) async throws -> Todo
}



class SaveTodoUseCase: SaveTodoUseCaseProtocol{

    

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    
    func execute(existingTodo:Todo?, title:String, description:String?, start:Date?, end:Date?, completion:Bool, reminder:Bool?) async throws -> Todo {
        
        guard let user = manager.dataStoreRepo.user else { throw AppError.failedToSave }

        var newTodo:Todo
        
        if (existingTodo != nil) {
            newTodo = existingTodo!
            newTodo.content = title
            newTodo.description = description
            newTodo.start = start != nil ? Temporal.DateTime(start!) : nil
            newTodo.end = end != nil ? Temporal.DateTime(end!) : nil
            newTodo.completion = completion
            newTodo.reminder = false
        } else {
            newTodo = Todo(content: title, fromUser: user, completion: completion, reminder: false)

            
        }
        
        return try await manager.dataStoreRepo.saveTodo(newTodo)
        
        
    }
    
    
    }
