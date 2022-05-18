//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import SwiftUI

struct EWAvatarView:View {
    @Binding var image:Image
    
    var body: some View {
        image.modifier(AvatarModifier(style: .medium))
    }
}


struct EWAvatarView_Previews:PreviewProvider {
    @State static var image = Image(systemName: "person.fill")
    
    public static var previews:some View {
        EWAvatarView(image: $image)
    }
}


struct AvatarModifier: ViewModifier {
    enum Style {
        case large
        case medium
        case small
    }
    
    var style: Style

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
