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
    @EnvironmentObject var commitvm:CommitViewModel

    @State var isUpdatingBranch = false
    @State var isShowingLinkedItemView = false
    @State var isShowingLinkView:Bool = false

    func extractMemberNames(branch:FeuBranch) -> [String]? {
        if branch.actions != nil {
            let names = branch.actions!.compactMap { action in
                action.creator?.username
            }
            return names
        } else {
            return nil
        }
    }
    
    var body: some View {
            
            ScrollView(.vertical, showsIndicators: false){
                
                LazyVStack(alignment: .leading, spacing: .ewPaddingVerticalLarge){
                    ForEach(branchvm.fetchedAllFeuBranches, id: \.id) { branch in

                        NavigationLink {
                            BranchLinkedItemsView(commitList: branchvm.fetchedAllCommits, searchInput:$branchvm.searchInput)
                                .task {
                                    branchvm.fetchedAllCommits = []
                                    await branchvm.getAllCommitsFromBranch(branch: branch)
                                }
                        } label: {
                            EWCardBranch(coverImage:nil, privacyType: branch.privacyType, title: branch.title, description: branch.description, memberNames: extractMemberNames(branch: branch) ,memberAvatars: nil, numOfLikes: branch.numOfLikes, numOfDislikes: branch.numOfDislikes, numOfSubs: branch.numOfSubs, numOfShares: branch.numOfShares, numOfComments: branch.numOfComments)
                        }

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
                                    branchvm.branch = branchvm.fetchedAllFeuBranches.filter({$0.id == branch.id})[0]
                                    
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
