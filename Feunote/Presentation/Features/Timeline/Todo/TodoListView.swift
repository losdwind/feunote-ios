//
//  TodoListView.swift
//  Beliski
//
//  Created by Wind Losd on 2021/5/8.
//

import SwiftUI

struct TodoListView: View {
    
    // FETCHING DATA
    @ObservedObject var todovm: TodoViewModel
    
    @State var isUpdatingTodo = false
    @State var isLinkingItem = false
    @State var isShowingLinkedItemView: Bool = false
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    // MARK: - FUNCTION
    
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack{
            LazyVStack(alignment: .leading) {
                ForEach(todovm.fetchedTodos, id: \.id){ todo in
                    
                    EWCardTodo(content: todovm.todo.content, description: todovm.todo.description, completion: todovm.todo.completion, start: todovm.todo.start, end: todovm.todo.start)
                        .background {
                            NavigationLink(destination: EmptyView(), isActive: $isShowingLinkedItemView) {
                                EmptyView()
                            }
                        }.contextMenu {
                            
                            // Delete
                            Button(action: {
                                task {
                                    await todovm.deleteTodo(todo: todo)
                                }
                                
                            }
                                   , label: { Label(
                                    title: { Text("Delete") },
                                    icon: { Image(systemName: "trash.circle") }) })
                            
                            // Edit
                            Button(action: {
                                isUpdatingTodo = true
                                todovm.todo = todo
                                
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
                        .frame(alignment: .topLeading)

                    
                    
                    
                        .sheet(isPresented: $isLinkingItem) {
//                            SearchAndLinkingView(item: todo, searchvm: searchvm, tagPanelvm: tagPanelvm)
                            
                            
                            
                        }
                        .onTapGesture(perform: {
                            isShowingLinkedItemView.toggle()
                            
                        })
                }
                } //: VStack
                                      
            .padding()
            .frame(maxWidth: 640)
            .blur(radius: isUpdatingTodo ? 5 : 0)
                
                
                if isUpdatingTodo {
                  BlankView(
                    backgroundColor: isDarkMode ? Color.black : Color.gray,
                    backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                    .onTapGesture {
                      withAnimation() {
                          isUpdatingTodo = false
                      }
                    }
                  
                    TodoEditorView(todovm: todovm)
                }
                
                
            } //:ZStack
        }
        
        
        
    }
}

                                      

struct TodoListView_Previews: PreviewProvider {
    
    static var todovm: TodoViewModel {
        let todovm = TodoViewModel()
        todovm.fetchTodos { _ in }
        return todovm
    }
    
    static var previews: some View {
        TodoListView(todovm: TodoViewModel(), searchvm: SearchViewModel(), tagPanelvm: TagPanelViewModel(), dataLinkedManager: DataLinkedManager())
            .previewLayout(.sizeThatFits)
        
    }
}
