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

struct EWAvatar:View {
    var imageURL:String
    var style:avatarStyleEnum = .medium
    
    var body: some View {
            AsyncImage(url: URL(string: imageURL))
                .modifier(AvatarModifier(style: style))
    }
}

struct EWAvatarAdd:View {
    var action:()-> Void
    var style:avatarStyleEnum = .medium
    
    var body: some View {
        Button {
            action()
        } label: {
            Image("plus")
                .modifier(AvatarModifier(style: style))
                .border(Color.ewGray900, width: 1)
        }

        
    }
    
}

struct EWAvatarGroup:View {
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





struct EWAvatarView_Previews:PreviewProvider {
    @State static var imageURL:String = "https://picsum.photos/200"
    @State static var imageURLs:[String] = ["https://picsum.photos/200", "https://picsum.photos/200", "https://picsum.photos/200"]
    
    public static var previews:some View {
        EWAvatar(imageURL: imageURL)
        EWAvatarGroup(imageURLs: imageURLs)
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
//                .overlay(Circle().stroke(lineWidth: lineWidth))
    }
        
    }
}
