//
//  Photos.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/10.
//

import SwiftUI

struct EWPhotosAdd: View {
    @Environment(\.colorScheme) var colorScheme
    @State var isShowingImagePicker: Bool = false
    @Binding var images:[UIImage]

    var body: some View {
        HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall) {
            ScrollView(.horizontal, showsIndicators: false) {
                if images != [] {
                    ForEach(images, id: \.self) {
                        image in
                        if image != nil {
                            Image(uiImage: image)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                        } else {
                            Image(systemName: "exclamationmark.icloud")
                                .frame(width: 50, height: 50)
                        }
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
        .sheet(isPresented: $isShowingImagePicker) {
                print("images:\(String(describing: images.count))")
        } content: {
            ImagePickers(images: $images)
                .preferredColorScheme(colorScheme)
                .accentColor(colorScheme == .light ? .ewPrimaryBase : .ewPrimary100)
        }
    }
}

struct EWPhotosAdd_Previews: PreviewProvider {
    @State static var images:[UIImage] = []
    static var previews: some View {
        EWPhotosAdd(images: $images)
    }
}
