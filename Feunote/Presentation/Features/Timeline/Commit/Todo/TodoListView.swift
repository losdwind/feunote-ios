//
//  TodoListView.swift
//  Beliski
//
//  Created by Wind Losd on 2021/5/8.
//

import SwiftUI

struct TodoListView: View {
    
    // FETCHING DATA
    @ObservedObject var commitvm: CommitViewModel
    
    @State var isUpdatingTodo = false
    @State var isLinkingItem = false
    @State var isShowingLinkedItemView: Bool = false
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    // MARK: - FUNCTION
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack{
            LazyVStack(alignment: .leading) {
                ForEach(commitvm.fetchedAllCommits.filter({ commit in
                    commit.commitType == .todo
                }), id: \.id){ todo in
                    EWCardTodo(content: commitvm.commit.titleOrName, description: commitvm.commit.description, completion:                         $commitvm.commit.todoCompletion, start: commitvm.commit.todoStart, end: commitvm.commit.todoEnd)
                        .background {
                            NavigationLink(destination: EmptyView(), isActive: $isShowingLinkedItemView) {
                                EmptyView()
                            }
                        }.contextMenu {
                            // Delete
                            Button(action: {
                                Task {
                                    await commitvm.deleteCommit(commit: todo)
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
                  
                    TodoEditorView(commitvm: commitvm)
                }
                
                
            } //:ZStack
        }
        
        
        
    }
}

                                      

struct TodoListView_Previews: PreviewProvider {
    
    static var commitvm:CommitViewModel = CommitViewModel(saveCommitUseCase: SaveCommitUseCase(), deleteCommitUseCase: DeleteCommitUseCase(), getAllCommitsUseCase: GetAllCommitsUseCase())

    
    static var previews: some View {
        TodoListView(commitvm: commitvm)
            .previewLayout(.sizeThatFits)
        
    }
}
