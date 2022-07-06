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
    @Binding var images:[UIImage?]?
    
    @State private var internal_images:[UIImage]?
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: -Todo Here we shall handle the getter and setter of images binding
    init(title:Binding<String?>, content:Binding<String?>,images:Binding<[UIImage?]?>){
        self._title = title
        self._content = content
        self._images = images
        self.internal_images = images.wrappedValue?.compactMap({$0})
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
            EWTextField(input: $title ?? "" , icon: nil, placeholder: "Title")
            EWTextFieldMultiline(input: $content ?? "", placeholder: "Description")
            
            HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall) {
                if images != nil {
                    ForEach(images!, id:\.self){
                        image in
                        if image != nil {
                            Image(uiImage: image!)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                        } else {
                            Image(systemName: "exclamationmark.icloud")
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
//        .sheet(isPresented: $isShowingImagePicker){
//            ImagePickers(images:$internal_images ?? [UIImage]() )
//                .preferredColorScheme(colorScheme)
//                .accentColor(colorScheme == .light ? .ewPrimaryBase: .ewPrimary100)
//        }
    }
}

struct EWCardMomentEditor_Previews: PreviewProvider {
    @State static var title:String? = nil
    @State static var content:String? = nil
    @State static var isShowingImagePicker = false
    @State static var images:[UIImage?]? = nil

    static var previews: some View {
        EWCardMomentEditor(title: $title ?? "", content: $content ?? "", images: $images)
    }
}
