//
//  MomentEditorView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/8.
//

import SwiftUI

struct MomentEditorView: View {
    
    @EnvironmentObject var commitvm:CommitViewModel
    
    @State var imagePickerPresented = false
    @State var isShowingImageToggle = false
    
    
    
    @Environment(\.presentationMode) var presentationMode
    
    // new in iOS 15
    //    @Environment(\.dismiss) var dismiss
    
    
    
    
    var body: some View {
        
        VStack(alignment: .center, spacing: .ewPaddingVerticalLarge){
            // Navigation Bar
            EWNavigationBar(title: "Moment", iconLeftImage:Image("delete"), iconRightImage: Image("check")) {
                commitvm.commit = FeuCommit()
                presentationMode.wrappedValue.dismiss()
            } actionRight: {
                Task {
                    commitvm.commit.commitType = .moment
                    await commitvm.saveCommit(commit: commitvm.commit)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            
            
            EWCardMomentEditor(title:$commitvm.commit.titleOrName, content: $commitvm.commit.description, images: $commitvm.commit.photos)
            
        }
//        .toolbar{
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    commitvm.commit = FeuCommit()
//                    presentationMode.wrappedValue.dismiss()
//                } label: {
//                    Image("delete")
//                }
//
//            }
//
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button {
//                    Task {
//                        commitvm.commit.commitType = .moment
//                        await commitvm.saveCommit(commit: commitvm.commit)
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                } label: {
//                    Image("check")
//
//                }
//
//            }
//        }
        .padding()
        .transition(.move(edge: .bottom))
        .alert(isPresented: $commitvm.hasError) {
            Alert(title: Text("Message"), message: Text(commitvm.appError?.errorDescription ?? "default error"), dismissButton: .destructive(Text("Ok")))
        }
        
    }
    
}

struct MomentEditorView_Previews: PreviewProvider {
    static var previews: some View {
        MomentEditorView()
    }
}
