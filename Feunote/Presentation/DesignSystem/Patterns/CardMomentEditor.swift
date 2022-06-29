//
//  CardMomentEditor.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/10.
//

import SwiftUI

struct EWCardMomentEditor: View {
    @Binding var title:String?
    @Binding var content:String?
    @State var isShowingImagePicker:Bool = false
    @Binding var images:[UIImage]?
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
            EWTextField(input: $title ?? "" , icon: nil, placeholder: "Title")
            EWTextFieldMultiline(input: $content ?? "", placeholder: "Description")
            
            HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall) {
                if images != nil {
                    ForEach(images!, id:\.self){
                        image in
                            Image(uiImage: image)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)                   }
                }
                Button {
                    isShowingImagePicker.toggle()
                } label: {
                    Image("NewImage")
                        .ewRounded(width: 36)
                }
            }
            
        }
        .sheet(isPresented: $isShowingImagePicker){
                ImagePickers(images: $images ?? [UIImage]())
                .preferredColorScheme(colorScheme)
                .accentColor(colorScheme == .light ? .ewPrimaryBase: .ewPrimary100)
        }
    }
}

struct EWCardMomentEditor_Previews: PreviewProvider {
    @State static var title:String? = nil
    @State static var content:String? = nil
    @State static var isShowingImagePicker = false
    @State static var images:[UIImage]? = nil

    static var previews: some View {
        EWCardMomentEditor(title: $title ?? "", content: $content ?? "", images: $images ?? [UIImage]())
    }
}
