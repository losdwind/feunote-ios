//
//  CardPersonEditor.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/10.
//

import SwiftUI

struct EWCardPersonEditor: View {
    @Binding var name:String
    @Binding var description:String
    @Binding var image:UIImage?
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
            HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge) {
                ZStack(alignment: .center) {
                    if image != nil {
                        EWImageAvatar(image: image!)

                    }
                    EWAvatarAdd(image:$image , style: .small)
                        .opacity(0.2)

                }
                
                EWTextField(input: $name, icon: nil, placeholder: "Name")
            }
            EWTextFieldMultiline(input: $description, placeholder: "Description")
        }
    }
}

struct EWCardPersonEditor_Previews: PreviewProvider {
    @State static var name:String = ""
    @State static var description:String = ""
    @State static var image:UIImage?
    static var previews: some View {
        EWCardPersonEditor(name: $name, description: $description, image: $image)
    }
}
