//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import SwiftUI

enum AvatarStyleEnum {
    case small
    case medium
    case large
}

struct EWAvatarURL:View {
    var avatarURL:String
    var style:AvatarStyleEnum = .medium
    
    var body: some View {
            AsyncImage(url: URL(string: avatarURL))
                .modifier(AvatarModifier(style: style))
    }
}

struct EWAvatarImage:View {
    var avatar:UIImage
    var style:AvatarStyleEnum = .medium
    
    var body: some View {
        Image(uiImage: avatar)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .modifier(AvatarModifier(style: style))
    }
}



struct EWAvatarAdd:View {
    @Binding var avatar:UIImage?
    var style:AvatarStyleEnum = .medium
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isShowingImagePicker:Bool = false
    var body: some View {
        Button {
            isShowingImagePicker.toggle()
        } label: {
            Image("add")
                .modifier(AvatarModifier(style: style))

            

        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(image: $avatar)
                .preferredColorScheme(colorScheme)
                .accentColor(colorScheme == .light ? .ewPrimaryBase: .ewPrimary100)
        }

        
    }
    
}

struct EWAvatarURLGroup:View {
    var avatarURLs:[String]
    var style:AvatarStyleEnum = .medium
    var body: some View {
        HStack(alignment: .center, spacing: 8){
            ForEach(avatarURLs, id:\.self){
                url in
                AsyncImage(url: URL(string: url))
                    .modifier(AvatarModifier(style: style))
            }
            
        }
    }
}

struct EWAvatarGroup:View {
    var avatars:[UIImage]
    var style:AvatarStyleEnum = .medium
    var body: some View {
        HStack(alignment: .center, spacing: 8){
            ForEach(avatars, id:\.self){
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
            EWAvatarAdd(avatar: $image)
            EWAvatarURL(avatarURL: imageURL)
            EWAvatarURLGroup(avatarURLs: imageURLs)
            EWAvatarGroup(avatars: images)
        }

    }
}


struct AvatarModifier: ViewModifier {
    var style: AvatarStyleEnum

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
