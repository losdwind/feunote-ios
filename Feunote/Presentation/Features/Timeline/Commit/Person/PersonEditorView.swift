//
//  PersonEditorView.swift
//  Beliski
//
//  Created by Wind Losd on 2021/5/25.
//

import SwiftUI

//import iTextField
//import iPhoneNumberField

import Kingfisher
struct PersonEditorView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @State var avatarPickerPresented = false
    @State var photosPickerPresented = false
    @State var isShowingImageToggle = false

    
    
    @EnvironmentObject var commitvm:CommitViewModel
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    
    var body: some View {

            
            VStack(alignment:.leading, spacing: .ewPaddingVerticalLarge){
                
                EWNavigationBar(title: "Person", iconLeftImage: Image("delete"), iconRightImage: Image("check"), actionLeft: {
                    commitvm.commit = FeuCommit()
                    presentationMode.wrappedValue.dismiss()
                }, actionRight: {
                    Task{
                        commitvm.commit.commitType = .person
                        await commitvm.saveCommit(commit: commitvm.commit)
                        presentationMode.wrappedValue.dismiss()
                    }
                })
                
                EWCardPersonEditor(name: $commitvm.commit.titleOrName ?? "", description: $commitvm.commit.description ?? "", image: $commitvm.commit.personAvatar)
            }
            .padding()
            .transition(.move(edge: .bottom))
            .alert(isPresented: $commitvm.hasError) {
                
                Alert(title: Text("Message"), message: Text(commitvm.appError?.errorDescription ?? "default error"), dismissButton: .destructive(Text("Ok")))
            }
            .sheet(isPresented: $avatarPickerPresented
                   , content: {
                ImagePicker(image: $commitvm.commit.personAvatar ?? UIImage())
                    .preferredColorScheme(colorScheme)
                    .accentColor(colorScheme == .light ? .accentColor: .secondary)
            })
//            .sheet(isPresented: $photosPickerPresented) {
//                ImagePickers(images: Binding(commitvm.commit.photos.flatMap{$0.compactMap{$0}}))
//            }
        
        
        
        
        
        
    }
    }


struct PersonEditorView_Previews: PreviewProvider {
    static var previews: some View {
        PersonEditorView()
)
    }
}
