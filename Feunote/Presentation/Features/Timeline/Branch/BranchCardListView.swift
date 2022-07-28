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
                
                LazyVStack(alignment: .leading, spacing: .ewPaddingVerticalLarge){
                    ForEach(branchvm.fetchedAllBranches, id: \.id) { branch in
 
                        EWCardBranch(coverImage:nil, privacyType: branch.privacyType, title: branch.title, description: branch.description, author: branch.owner, members: branch.members, numOfLikes: branch.numOfLikes, numOfDislikes: branch.numOfDislikes, numOfSubs: branch.numOfSubs, numOfShares: branch.numOfShares, numOfComments: branch.numOfComments)
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
                                .disabled(branch.owner != AppRepoManager.shared.dataStoreRepo.amplifyUser?.id)
                                
                                
                                
                                // Edit
                                Button{
                                    branchvm.branch = branch
                                    
                                    isUpdatingBranch = true
                                    
                                } label:{Label(
                                title: { Text("Edit") },
                                icon: { Image(systemName: "pencil.circle") })}
                                .disabled(branch.owner != AppRepoManager.shared.dataStoreRepo.amplifyUser?.id)
                                
                            }
                            .onTapGesture {
                                isShowingLinkedItemView.toggle()
                            } //: onTapGesture
                        
                            .sheet(isPresented: $isUpdatingBranch){
                                // MARK: - think about the invalide id, because maybe the moment haven't yet been uploaded
                                BranchCardEditorView()
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
            }
            
        
    }
}

struct BranchCardListView_Previews: PreviewProvider {
    static var previews: some View {
        BranchCardListView()
    }
}
