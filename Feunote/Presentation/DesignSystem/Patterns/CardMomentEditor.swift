//
//  CardMomentEditor.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/10.
//

import SwiftUI

struct CardMomentEditor: View {
    @Binding var content:String
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
            EWTextFieldMultiline(input: $content, placeholder: "Description")
            Button {
            } label: {
                Image("NewImage")
                    .ewRounded(width: 36)
            }

        }
    }
}

struct CardMomentEditor_Previews: PreviewProvider {
    @State static var content:String = ""

    static var previews: some View {
        CardMomentEditor(content: $content)
    }
}
