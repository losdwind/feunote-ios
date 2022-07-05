//
//  BranchCardListView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/31.
//

import SwiftUI
import Amplify

struct BranchCardListView: View {
    
    @EnvironmentObject var branchvm:BranchViewModel
    @EnvironmentObject var profilevm:ProfileViewModel

    @State var isUpdatingBranch = false
    @State var isShowingLinkedItemView = false
    @State var isShowingLinkView:Bool = false
    
    var body: some View {
            
            ScrollView(.vertical, showsIndicators: false){
                
                LazyVStack{
                    ForEach(branchvm.fetchedAllBranches, id: \.id) { branch in
 
                        EWCardBranch(coverImage:nil, title: branchvm.branch.title, description: branchvm.branch.description, author: branchvm.branch.owner, members: branchvm.branch.members, numOfLikes: branchvm.branch.numOfLikes, numOfDislikes: branchvm.branch.numOfDislikes, numOfSubs: branchvm.branch.numOfSubs, numOfShares: branchvm.branch.numOfShares, numOfComments: branchvm.branch.numOfComments)
                            .background{
                                NavigationLink(destination: EmptyView(), isActive: $isShowingLinkedItemView) {
                                    EmptyView()
                                }

                            } //: background
                        
                            .contextMenu {
                                // Delete
                                Button {
                                    Task{
                                        await branchvm.deleteBranch(branchID: branch.id)
                                    }
                                    
                                } label: {
                                    
                                    Label(title: {
                                        Text("Delete")
                                    }, icon: {
                                        Image(systemName: "trash.circle")
                                    })
                                }
                                .disabled(branch.owner != profilevm.currentUser)
                                
                                
                                
                                // Edit
                                Button{
                                    branchvm.branch = branch
                                    
                                    isUpdatingBranch = true
                                    
                                } label:{Label(
                                title: { Text("Edit") },
                                icon: { Image(systemName: "pencil.circle") })}
                                .disabled(branch.owner != profilevm.currentUser)
                                
                                
                                
                            }
                        
                            .onTapGesture {
                                isShowingLinkedItemView.toggle()
                            } //: onTapGesture
                        
                            .sheet(isPresented: $isUpdatingBranch){
                                // MARK: - think about the invalide id, because maybe the moment haven't yet been uploaded
                                BranchCardEditorView(branchvm: branchvm)
                            }
                            .sheet(isPresented: $isShowingLinkView, onDismiss: {
                                Task{
                                    await branchvm.saveBranch()
                                }
                                
                            }){
//                                SearchAndLinkingView(item:branch, searchvm: searchvm, tagPanelvm: tagPanelvm)
                                EmptyView()
                                
                            }
                            
                        
                        
                    }
                    
                }
                .padding()
                .frame(maxWidth: 640)
                .task {
                    await branchvm.fetchAllBranchs(page: 1)
                }
            }
            
        
    }
}

struct BranchCardListView_Previews: PreviewProvider {
    static var previews: some View {
        BranchCardListView()
    }
}
