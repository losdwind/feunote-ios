//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import SwiftUI

enum avatarStyleEnum {
    case small
    case medium
    case large
}

struct EWAvatarURL:View {
    var imageURL:String
    var style:avatarStyleEnum = .medium
    
    var body: some View {
            AsyncImage(url: URL(string: imageURL))
                .modifier(AvatarModifier(style: style))
    }
}

struct EWAvatarImage:View {
    var image:UIImage
    var style:avatarStyleEnum = .medium
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .modifier(AvatarModifier(style: style))
    }
}

struct EWAvatarAdd:View {
    @Binding var image:UIImage?
    var style:avatarStyleEnum = .medium
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isShowingImagePicker:Bool = false
    var body: some View {
        Button {
            isShowingImagePicker.toggle()
        } label: {
            Image("add")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundColor(.ewGray900)
                .modifier(AvatarModifier(style: style))
                .border(Color.ewGray900, width: 2)
                .background(Color.ewGray50)

            

        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(image: $image)
                .preferredColorScheme(colorScheme)
                .accentColor(colorScheme == .light ? .ewPrimaryBase: .ewPrimary100)
        }

        
    }
    
}

struct EWAvatarURLGroup:View {
    var imageURLs:[String]
    var style:avatarStyleEnum = .medium
    var body: some View {
        HStack(alignment: .center, spacing: 8){
            ForEach(imageURLs, id:\.self){
                url in
                AsyncImage(url: URL(string: url))
                    .modifier(AvatarModifier(style: style))
            }
            
        }
    }
}

struct EWAvatarGroup:View {
    var images:[UIImage]
    var style:avatarStyleEnum = .medium
    var body: some View {
        HStack(alignment: .center, spacing: 8){
            ForEach(images, id:\.self){
                image in
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .modifier(AvatarModifier(style: style))
            }
            
        }
    }
}





struct EWAvatarView_Previews:PreviewProvider {
    @State static var imageURL:String = "https://picsum.photos/200"
    @State static var imageURLs:[String] = ["https://picsum.photos/200", "https://picsum.photos/200", "https://picsum.photos/200"]
    @State static var images:[UIImage] = [UIImage(systemName: "person.fill")!, UIImage(systemName: "person.fill")!]
    @State static var image:UIImage?
    
    public static var previews:some View {
        VStack {
            EWAvatarAdd(image: $image)
            EWAvatarURL(imageURL: imageURL)
            EWAvatarURLGroup(imageURLs: imageURLs)
            EWAvatarGroup(images: images)
        }

    }
}


struct AvatarModifier: ViewModifier {
//    enum Style {
//        case large
//        case medium
//        case small
//    }
//
    var style: avatarStyleEnum

    func body(content: Content) -> some View {
        switch style {
        case .large:
            content
                .frame(width: 130, height: 110)
                .clipShape(RoundedRectangle(cornerRadius: .ewCornerRadiusDefault))
        case .medium:
            content

                .frame(width: 32, height: 32)
                .clipShape(Circle())
        case .small:
            content
            .frame(width: 24, height: 24)
            .clipShape(Circle())
    }
        
    }
}
