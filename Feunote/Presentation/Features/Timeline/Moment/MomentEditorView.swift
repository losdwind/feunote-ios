//
//  MomentEditorView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/8.
//

import SwiftUI

struct MomentEditorView: View {
    
    @ObservedObject var momentvm:MomentViewModel
    
    @State var imagePickerPresented = false
    @State var isShowingImageToggle = false

    
    @Environment(\.colorScheme) var colorScheme

    @Environment(\.presentationMode) var presentationMode
    
    // new in iOS 15
    //    @Environment(\.dismiss) var dismiss
    
    
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .center, spacing:.ewPaddingVerticalLarge){
            
                // Navigation Bar
                EWNavigationBar(title: "Moment", iconLeftImage:Image("delete"), iconRightImage: Image(name: "check")) {
                    print("action left activated")
                } actionRight: {
                    print("action right activated")
                }

                   
                EWCardMomentEditor(title:momentvm.moment.title, content: $momentvm.moment.content, isShowingImagePicker: $imagePickerPresented, imageURLs: co)

   
            
                    
                    
            }
            .padding()

            } //: ScrollView
           .transition(.move(edge: .bottom))
           .alert(isPresented: $momentvm.hasError) {
                
               Alert(title: Text("Message"), message: Text(momentvm.appError.errorDescription ?? ""), dismissButton: .destructive(Text("Ok")))
            }
            .sheet(isPresented: $imagePickerPresented
                   , content: {
                ImagePickers(images: $momentvm.images)
                    .preferredColorScheme(colorScheme)
                    .accentColor(colorScheme == .light ? .accentColor: .secondary)
                
            })
        
    }
    
}

struct MomentEditorView_Previews: PreviewProvider {
    static var previews: some View {
        MomentEditorView(momentvm: MomentViewModel())
    }
}
