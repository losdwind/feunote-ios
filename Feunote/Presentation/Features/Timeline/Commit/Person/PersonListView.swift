//
//  PersonListView.swift
//  Beliski
//
//  Created by Wind Losd on 2021/5/25.
//

import SwiftUI

struct PersonListView: View {
    @ObservedObject var commitvm: CommitViewModel
    
    @State var isUpdatingPerson: Bool = false
    @State var isShowingPersonDetail: Bool = false
    @State var isShowingLinkView:Bool = false
    @State var isShowingLinkedItemView: Bool = false
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack{
                    ForEach(commitvm.fetchedAllPersons, id:\.id){ person in
                        EWCardPerson(name: commitvm.commit.titleOrName , avatarImage: commitvm.commit.personAvatar, address: commitvm.commit.personAddress, birthday: commitvm.commit.personBirthday, description: commitvm.commit.description)
//                                .background{
//                                    NavigationLink(destination:EmptyView(), isActive: $isShowingLinkedItemView){
//                                        EmptyView()
//                                    }
//                                }
                                .contextMenu{
                                    
                                    // Detail
                                    Button {
                                        isShowingPersonDetail.toggle()
                                    } label: {
                                        Label(
                                         title: { Text("Detail") },
                                         icon: { Image(systemName: "trash.circle") })
                                    }

                                    // Delete
                                    Button(action:{
                                        Task {
                                            
                                            await commitvm.deleteCommit(commitID: person.id)
                                        }
                                        
                                    }
                                           ,label:{Label(
                                            title: { Text("Delete") },
                                            icon: { Image(systemName: "trash.circle") })})
                                    
                                    
                                    // Edit
                                    Button(action:{
                                        commitvm.commit = person
                                        isUpdatingPerson = true
                                        
                                    }
                                           ,label:{Label(
                                            title: { Text("Edit") },
                                            icon: { Image(systemName: "pencil.circle") })})
                                    
                                    
                                    // Link
                                    Button(action:{
                                        isShowingLinkView = true
                                        
                                        
                                    }
                                           ,label:{Label(
                                            title: { Text("Link") },
                                            icon: { Image(systemName: "link.circle") })})
                                    
                                }
                                .sheet(isPresented: $isShowingPersonDetail){
                                    PersonDetailView(commit: person)
                                }
                                .sheet(isPresented: $isShowingLinkView, onDismiss: {
                                }){
//                                    SearchAndLinkingView(item: person,searchvm: searchvm, tagPanelvm: tagPanelvm)
                                }
                                .sheet(isPresented: $isUpdatingPerson){
                                    PersonEditorView(commitvm: commitvm)
                                }
                                .onTapGesture(perform: {
                                    isShowingLinkedItemView.toggle()
                                })
                    
                        

                        
                    }
                }
                .padding()
                .frame(maxWidth: 640)

            }
            
        
            
    }
}

struct PersonListView_Previews: PreviewProvider {
    static var previews: some View {
        PersonListView(commitvm: CommitViewModel(saveCommitUseCase: SaveCommitUseCase(), deleteCommitUseCase: DeleteCommitUseCase(), getAllCommitsUseCase: GetAllCommitsUseCase(), viewDataMapper: ViewDataMapper())
)
    }
}
