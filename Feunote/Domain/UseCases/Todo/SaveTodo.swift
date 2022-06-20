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
        
        guard let user = dataStoreRepo.user else { return }

        var newTodo:Todo
        if existingTodo {
            newTodo = existingTodo!
            newTodo.content = title
            newTodo.description = description
            newTodo.start = start
            newTodo.end = end
            newTodo.completion = completion
            newTodo.reminder = reminder
        } else {
            newTodo = Todo(content: title, description: description, fromUser: user, completion: completion, reminder: reminder, start: start, end: end)
        }
        
        return try await manager.dataStoreRepo.saveTodo(newTodo)
        
        
    }
    
    
    }
