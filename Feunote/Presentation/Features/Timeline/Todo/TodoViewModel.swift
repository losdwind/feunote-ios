//
//  TodoViewModel.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/16.
//

import Foundation

class TodoViewModel: ObservableObject {
    internal init(saveTodoUseCase: SaveTodoUseCaseProtocol, deleteTodoUseCase: DeleteTodoUseCaseProtocol, getAllTodosUseCase: GetAllTodosUseCaseProtocol) {
        self.saveTodoUseCase = saveTodoUseCase
        self.deleteTodoUseCase = deleteTodoUseCase
        self.getAllTodosUseCase = getAllTodosUseCase
    }
    
    
    @Published var todo:Todo = Todo(content: "initalization", fromUser: User(avatarURL: "", nickName: ""), completion: false, reminder: false)
    @Published var reminder: Date = Date()
    @Published var start:Date?
    @Published var end:Date?
    @Published var fetchedAllTodos:[Todo] = [Todo]()
    
    private var saveTodoUseCase:SaveTodoUseCaseProtocol
    private var deleteTodoUseCase:DeleteTodoUseCaseProtocol
    private var getAllTodosUseCase:GetAllTodosUseCaseProtocol
    
    @Published var hasError = false
    @Published var appError:AppError?
    
    func saveTodo() async {
        do {
            try await saveTodoUseCase.execute(existingTodo: todo, title: todo.content, description: todo.description,start: start,end: end, completion: todo.completion, reminder: todo.reminder)
            playSound(sound: "sound-ding", type: "mp3")
            todo = Todo(content: "initalization", fromUser: User(avatarURL: "", nickName: ""), completion: false, reminder: false)
        }catch(let error){
            hasError = true
            appError = error as? AppError
        }
    }
    
    
    func deleteTodo(todo: Todo) async{
        
        do {
            try await deleteTodoUseCase.execute(todo: todo)
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
        
    }
    
    
    
    
    func fetchAllTodos() async {
        do {
            fetchedAllTodos = try await getAllTodosUseCase.execute(page: 1)
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
    }
    
    
    func fetchTodayTodos() async {
       
    }
    
    
    
    
    
    

}

