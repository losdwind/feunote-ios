//
//  TodoViewModel.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/16.
//

import Foundation
import Foundation
import CoreData
import Firebase
import FirebaseFirestoreSwift

class TodoViewModel: ObservableObject {
    
    @Published var todo:Todo = Todo()
    @Published var reminder: Date = Date()
    @Published var fetchedTodos:[Todo] = [Todo]()
    
    
    func uploadTodo(handler: @escaping (_ success: Bool) -> ()) {
        
        guard let userID = AuthViewModel.shared.userID else {
            print("userID is not valid in uploadTodo func")
            handler(false)
            return }
        
        if todo.ownerID == "" {
            todo.ownerID = userID
        }
        
        if todo.ownerID != userID {
                handler(false)
                print("this todo does not belong to you")
                return
            }
        
        todo.reminder = Timestamp(date: self.reminder)

            
            
        let document = COLLECTION_USERS.document(userID).collection("todos").document(todo.id)
       
       
        
        
        
        
        
        // MARK: - here I disabled the uploadImage because i want to upload right after the imagePicker
        

        
        do {
            try document.setData(from: todo)
            handler(true)
            
        } catch let error {
            print("Error upload moment to Firestore: \(error)")
            handler(false)
        }


    }
    
    
    func deleteTodo(todo: Todo, handler: @escaping (_ success: Bool) -> ()){
        
        guard let userID = AuthViewModel.shared.userID else {
            print("userID is not valid")
            return }
        
        
        COLLECTION_USERS.document(userID).collection("todos").document(todo.id).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                    handler(false)
                    return
                } else {
                    print("Document successfully removed!")
                    handler(true)
                    return
                }
            }
      
        
    }
    
    
    
    
    func fetchTodos(handler: @escaping (_ success: Bool) -> ()) {
        guard let userID = AuthViewModel.shared.userID else {
            print("userID is not valid here in fetchTodos function")
            return
        }
        
        COLLECTION_USERS.document(userID).collection("todos").order(by: "localTimestamp", descending: true).addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.fetchedTodos = documents.compactMap({try? $0.data(as: Todo.self)})
            handler(true)
        }
    }
    
    
    func fetchTodayTodos(handler: @escaping (_ success: Bool) -> ()) {
        guard let userID = AuthViewModel.shared.userID else {
            print("userID is not valid here in fetchTodos function")
            return
        }
        
        let dayStart = Calendar.current.startOfDay(for: Date())
        
        COLLECTION_USERS.document(userID).collection("todos").whereField("localTimestamp", isGreaterThanOrEqualTo: Timestamp(date: dayStart)).order(by: "localTimestamp", descending: true).addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.fetchedTodos = documents.compactMap({try? $0.data(as: Todo.self)})
            handler(true)
        }
    }
    
    
    
    
    
    

}

