//
//  Images.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import SwiftUI

extension Image {
    // MARK: Avatars

    /// Turn image into a circular avatar
    func ewAvatarCircle() -> some View {
        resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }

    /// Turn image into a rounded rectangle avatar
    func ewAvatarRounded() -> some View {
        resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }

    // MARK: Styled Images

    /// Modify image to fit a square format
    func ewSquare(width: CGFloat) -> some View {
        resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: width)
    }

    /// Modify image to fit a rounded corners square format
    func ewRounded(width: CGFloat) -> some View {
        resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: width)
            .clipShape(RoundedRectangle(cornerRadius: width / 10.0))
    }
}

struct Images_Previews_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                Image("appIcon")
                    .ewAvatarCircle()

                Image("appIcon")
                    .ewAvatarRounded()

            }.padding()

            HStack(spacing: 20) {
                Image("appIcon")
                    .ewSquare(width: 90)
                Image("appIcon")
                    .ewRounded(width: 90)
            }.padding()
        }
    }
}
