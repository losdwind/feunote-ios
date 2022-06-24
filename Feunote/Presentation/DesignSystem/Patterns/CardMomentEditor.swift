//
//  CardMomentEditor.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/10.
//

import SwiftUI

struct EWCardMomentEditor: View {
    @Binding var title:String
    @Binding var content:String
    @Binding var isShowingImagePicker:Bool
    @Binding var imageURLs:[String?]?
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
            EWTextField(input: $title , icon: nil, placeholder: "Title")
            EWTextFieldMultiline(input: $content, placeholder: "Description")
            
            HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall) {
                if imageURLs != nil {
                    ForEach(imageURLs!, id:\.self){
                        imageURL in
                        if imageURL != nil {
                            AsyncImage(url: URL(string: imageURL!))
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                        }
                    }
                }
                Button {
                    isShowingImagePicker.toggle()
                } label: {
                    Image("NewImage")
                        .ewRounded(width: 36)
                }
            }
            
        }
    }
}

struct EWCardMomentEditor_Previews: PreviewProvider {
    @State static var title:String = ""
    @State static var content:String = ""
    @State static var isShowingImagePicker = false
    @State static var imageURLS:[String?]?

    static var previews: some View {
        EWCardMomentEditor(title: $title, content: $content, isShowingImagePicker: $isShowingImagePicker, imageURLs: $imageURLS)
    }
}
