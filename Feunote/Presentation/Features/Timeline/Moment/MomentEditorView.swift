//
//  MomentEditorView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/8.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import UIKit

struct MomentEditorView: View {
    
    @ObservedObject var momentvm:MomentViewModel
    
    @State var imagePickerPresented = false
    @State var isShowingImageToggle = false
    @State var alertMsg = ""
    @State var showAlert = false
    
    @Environment(\.colorScheme) var colorScheme

    @Environment(\.presentationMode) var presentationMode
    
    // new in iOS 15
    //    @Environment(\.dismiss) var dismiss
    
    
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing:20){
            
                // Navigation Bar
                NavigationBar(title: "Moment", iconLeftImage:Image(name:"delete"), iconRightImage: Image(name: "check")) {
                    print("action left activated")
                } actionRight: {
                    print("action right activated")
                }

                   
                CardMomentEditor(content: $momentvm.moment.content, isShowingImagePicker: $imagePickerPresented)


               
               
               
               VStack(alignment: .leading, spacing: 15) {
                   
                       
                   
                   if isShowingImageToggle{
                       
                       Button {
                           
                           imagePickerPresented.toggle()
                           
                       } label: {
                           
                           ZStack{
                               
                               if momentvm.images.isEmpty && momentvm.moment.imageURLs.isEmpty{
                                   Image(systemName: "plus")
                                       .font(.largeTitle)
                                       .foregroundColor(.accentColor)
                               }
                               else{
                                   if momentvm.moment.imageURLs.isEmpty == false{
                                       
                                       ImageGridView(imageURLs: momentvm.moment.imageURLs)
                                   }
                                   if momentvm.images.isEmpty == false{
                                       
                                       ImageGridDataView(images: momentvm.images)
                                   }
                               }
                               
                           }
                           .frame(height: 200)
                           .cornerRadius(10)
                           .shadow(radius: 2)
                           .padding(.top,8)
                       }
                       .frame(maxWidth: .infinity,alignment: .center)
                       
                   }
                   
                   Divider()
               }
               .padding(.top,10)
                
                
                //                TimestampView(time:momentvm.moment.convertFIRTimestamptoString(timestamp: momentvm.moment.localTimestamp))
                
               
               VStack(alignment: .leading, spacing: 15) {
                   
                   Text("When happened")
                       .fontWeight(.semibold)
                       .foregroundColor(.gray)
                   
                   DatePicker("", selection: $momentvm.localTimestamp)
                       .labelsHidden()
                       .font(.system(size: 16).bold())
                   
                   Divider()
               }
               .padding(.top,10)
               
               
                
               VStack(alignment: .leading, spacing: 15) {
                   
                   Text("Tag")
                       .fontWeight(.semibold)
                       .foregroundColor(.gray)
                   
                   TagEditorView(tagNamesOfItem: $momentvm.moment.tagNames, tagvm:momentTagvm)
                       .font(.system(size: 16).bold())
                       .lineLimit(4)
                   
                   Divider()
               }
               .padding(.top,10)
               
                
                
                    
                    Button{
                        save()
                        playSound(sound: "sound-ding", type: "mp3")
                        presentationMode.wrappedValue.dismiss()

                        
                    } label: {
                        Text("Save")
                            .padding(.vertical,6)
                            .padding(.horizontal,30)
                    }
                    .modifier(SaveButtonBackground(isButtonDisabled: momentvm.moment.wordCount == 0))
                    .onTapGesture {
                        if momentvm.moment.wordCount == 0 {
                            playSound(sound: "sound-tap", type: "mp3")
                        }
                    }
                    
                    
            }
            .padding()

            } //: ScrollView
           .transition(.move(edge: .bottom))
            .alert(isPresented: $showAlert) {
                
                Alert(title: Text("Message"), message: Text(alertMsg), dismissButton: .destructive(Text("Ok")))
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
        MomentEditorView(momentvm: MomentViewModel(), momentTagvm: TagViewModel())
    }
}
