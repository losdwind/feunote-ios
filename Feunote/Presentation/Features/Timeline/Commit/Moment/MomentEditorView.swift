//
//  MomentEditorView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/8.
//

import SwiftUI

struct MomentEditorView: View {
    
    @ObservedObject var commitvm:CommitViewModel
    
    @State var imagePickerPresented = false
    @State var isShowingImageToggle = false

    

    @Environment(\.presentationMode) var presentationMode
    
    // new in iOS 15
    //    @Environment(\.dismiss) var dismiss
    
    
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .center, spacing:.ewPaddingVerticalLarge){
            
                // Navigation Bar
                EWNavigationBar(title: "Moment", iconLeftImage:Image("delete"), iconRightImage: Image("check")) {
                    commitvm.commit = FeuCommit()
                } actionRight: {
                    Task {
                        commitvm.commit.commitType = .moment
                        await commitvm.saveCommit()
                    }
                }

                   
                EWCardMomentEditor(title:$commitvm.commit.titleOrName, content: $commitvm.commit.description, images: $commitvm.commit.photos)
                    
            }
            .padding()

            } //: ScrollView
           .transition(.move(edge: .bottom))
           .alert(isPresented: $commitvm.hasError) {
                
               Alert(title: Text("Message"), message: Text(commitvm.appError?.errorDescription ?? "default error"), dismissButton: .destructive(Text("Ok")))
            }
            
        
    }
    
}

struct MomentEditorView_Previews: PreviewProvider {
    static var previews: some View {
        MomentEditorView(commitvm: CommitViewModel(saveCommitUseCase: SaveCommitUseCase(), deleteCommitUseCase: DeleteCommitUseCase(), getAllCommitsUseCase: GetAllCommitsUseCase(), viewDataMapper: ViewDataMapper()))
    }
}
