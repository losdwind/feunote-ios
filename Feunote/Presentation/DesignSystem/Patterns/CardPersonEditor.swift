//
//  CardPersonEditor.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/10.
//

import SwiftUI

struct CardPersonEditor: View {
    @Binding var name:String
    @Binding var description:String
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
            HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge) {
                EWAvatarAdd(action: {}, style: .small)
                EWTextField(input: $name, icon: Image("person.fill"), placeholder: "Name")
            }
            EWTextFieldMultiline(input: $description, placeholder: "He/She is very...")
        }
    }
}

struct CardPersonEditor_Previews: PreviewProvider {
    @State static var name:String = ""
    @State static var description:String = ""
    static var previews: some View {
        CardPersonEditor(name: $name, description: $description)
    }
}
