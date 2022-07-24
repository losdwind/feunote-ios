//
//  TodoListView.swift
//  Beliski
//
//  Created by Wind Losd on 2021/5/8.
//

import SwiftUI
import PartialSheet
struct TodoListView: View {
    
    // FETCHING DATA
    @EnvironmentObject var commitvm: CommitViewModel
    
    @State var isUpdatingTodo = false
    @State var isLinkingItem = false
    @State var isShowingLinkedItemView: Bool = false
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    // MARK: - FUNCTION
    
    
    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(commitvm.fetchedAllTodos, id: \.id){ todo in
                    EWCardTodo(content: todo.titleOrName, description: todo.description, completion: todo.todoCompletion, start: commitvm.commit.todoStart, end: commitvm.commit.todoEnd, action:{
                        Task {
                            await commitvm.toggleTodoCompletion(todo: todo)
                        }
                    })
                        .contextMenu {
                            // Delete
                            Button(action: {
                                Task {
                                    await commitvm.deleteCommit(commitID: todo.id)
                                }
                                
                            }
                                   , label: { Label(
                                    title: { Text("Delete") },
                                    icon: { Image(systemName: "trash.circle") }) })
                            
                            // Edit
                            Button(action: {
                                isUpdatingTodo = true
                                commitvm.commit = todo
                                
                            }
                                   , label: { Label(
                                    title: { Text("Edit") },
                                    icon: { Image(systemName: "pencil.circle") }) })
                            
                            // Link
                            Button(action: {
                                isLinkingItem = true
                                
                            }
                                   , label: { Label(
                                    title: { Text("Link") },
                                    icon: { Image(systemName: "link.circle") }) })
                        }

                        .partialSheet(isPresented: $isUpdatingTodo) {
                            TodoEditorView()

                        }
                            
                        }

                
                } //: VStack
                                      

                
                
        }

        
        
        
    }
}

                                      

struct TodoListView_Previews: PreviewProvider {
    
    static var previews: some View {
        TodoListView()
            .previewLayout(.sizeThatFits)
        
    }
}
