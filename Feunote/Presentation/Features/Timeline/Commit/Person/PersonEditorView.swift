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

    
    
    @ObservedObject var commitvm:CommitViewModel
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    
    var body: some View {
        
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment:.leading, spacing: .ewPaddingVerticalLarge){
                    
                    Spacer()
                        .onTapGesture{
                        presentationMode.wrappedValue.dismiss()
                    }

                    
                    EWNavigationBar(title: "Person", iconLeftImage: Image("delete"), iconRightImage: Image("check"), actionLeft: {
                        commitvm.commit = FeuCommit()
                    }, actionRight: {
                        Task{
                            commitvm.commit.commitType = .moment
                            await commitvm.saveCommit()

                        }
                    })
                    
                    EWCardPersonEditor(name: $commitvm.commit.titleOrName ?? "", description: $commitvm.commit.description ?? "")
                

                }
                .padding()
            

            } //: ScrollView
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
            .sheet(isPresented: $photosPickerPresented) {
                ImagePickers(images: $commitvm.commit.photos ?? [UIImage]())
            }
        
        
        
        
        
        
    }
    }


struct PersonEditorView_Previews: PreviewProvider {
    static var previews: some View {
        PersonEditorView(commitvm: CommitViewModel(saveCommitUseCase: SaveCommitUseCase(), deleteCommitUseCase: DeleteCommitUseCase(), getAllCommitsUseCase: GetAllCommitsUseCase(), viewDataMapper: ViewDataMapper())
)
    }
}
