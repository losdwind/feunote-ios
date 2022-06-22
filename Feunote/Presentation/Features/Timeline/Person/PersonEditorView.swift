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

    
    
    @ObservedObject var personvm:PersonViewModel
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    
    var body: some View {
        
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment:.leading, spacing: .ewPaddingVerticalLarge){
                    
                    Spacer()
                        .onTapGesture{
                        presentationMode.wrappedValue.dismiss()
                    }

                    
                    EWNavigationBar(title: "Person", iconLeftImage: Image(name:"delete"), iconRightImage: Image(name: "check"), actionLeft: {
                        
                    }, actionRight: {
                        Task{
                            await personvm.savePerson()

                        }
                    })
                    
                    EWCardPersonEditor(name: personvm.person.name, description: personvm.person.description)
                

                }
                .padding()
            

            } //: ScrollView
            .transition(.move(edge: .bottom))
            .alert(isPresented: $personvm.hasError) {
                
                Alert(title: Text("Message"), message: Text(personvm.appError.errorDescription), dismissButton: .destructive(Text("Ok")))
            }
            .sheet(isPresented: $avatarPickerPresented
                   , content: {
                ImagePicker(image: $personvm.avatarImage)
                    .preferredColorScheme(colorScheme)
                    .accentColor(colorScheme == .light ? .accentColor: .secondary)
            })
            .sheet(isPresented: $photosPickerPresented) {
                ImagePickers(images: $personvm.images)
            }
        
        
        
        
        
        
    }
    }


struct PersonEditorView_Previews: PreviewProvider {
    static var previews: some View {
        PersonEditorView(personTagvm: TagViewModel(), personvm: PersonViewModel())
    }
}
