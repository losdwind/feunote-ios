//
//  BranchCardListView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/31.
//

import SwiftUI
import Amplify

struct BranchCardListView: View {
    
    @ObservedObject var branchvm:BranchViewModel
    

    @State var isUpdatingBranch = false
    @State var isShowingLinkedItemView = false
    @State var isShowingLinkView:Bool = false
    
    var body: some View {
            
            ScrollView(.vertical, showsIndicators: false){
                
                LazyVStack{
                    ForEach(branchvm.fetchedAllBranches, id: \.self) { branch in
                        
                        EWCardBranch(title: branch.title, description: branch.description)
                            .background{
                                NavigationLink(destination: LinkedItemsView(dataLinkedManager: dataLinkedManager), isActive: $isShowingLinkedItemView) {
                                    EmptyView()
                                }
                                
                            } //: background
                        
                            .contextMenu{
                                // Delete
                                Button {
                                    branchvm.deleteBranch(branch: branch){success in
                                        if success {
                                            branchvm.fetchAllBranchs { _ in}
                                        }
                                        
                                    }
                                } label: {
                                    
                                    
                                    Label(title: {
                                        Text("Delete")
                                    }, icon: {
                                        Image(systemName: "trash.circle")
                                    })
                                }
                                .disabled(branch.fromUser != nil)
                                
                                
                                
                                // Edit
                                Button{
                                    branchvm.branch = branch
                                    
                                    isUpdatingBranch = true
                                    
                                } label:{Label(
                                title: { Text("Edit") },
                                icon: { Image(systemName: "pencil.circle") })}
                                .disabled(branch.fromUser != nil)
                                
                                
                                
                            }
                        
                        
                        
                            .onTapGesture {
                                isShowingLinkedItemView.toggle()
                            } //: onTapGesture
                        
                            .sheet(isPresented: $isUpdatingBranch){
                                // MARK: - think about the invalide id, because maybe the moment haven't yet been uploaded
                                
                                BranchCardEditorView(branchvm: branchvm)
                            }
                            .sheet(isPresented: $isShowingLinkView, onDismiss: {
                                branchvm.uploadBranch{ success in
                                    if success {
                                        print("successfully linked items and uploaded to firebase")
                                        branchvm.fetchAllBranchs(completion: {_ in})
                                    } else {
                                        print("Booom! failed to linke items and upload to firebase")
                                    }
                                    
                                }
                            }){
                                SearchAndLinkingView(item:branch, searchvm: searchvm, tagPanelvm: tagPanelvm)
                                
                            }
                        
                        
                    }
                    
                }
                .padding()
                .frame(maxWidth: 640)
                .onAppear(perform: {
                    branchvm.fetchAllBranchs(completion: {_ in})
                })
            }
            
        
    }
}

struct BranchCardListView_Previews: PreviewProvider {
    static var previews: some View {
        BranchCardListView(branchvm: BranchViewModel(), dataLinkedManager: DataLinkedManager(), searchvm: SearchViewModel(), tagPanelvm: TagPanelViewModel())
    }
}
