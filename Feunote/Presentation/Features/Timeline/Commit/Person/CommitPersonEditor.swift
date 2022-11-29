//
//  CardPersonEditor.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/10.
//

import SwiftUI

struct CommitPersonEditor: View {
    @Binding var person: AmplifyCommit
    @Binding var avatar: UIImage?
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
            HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge) {
                ZStack(alignment: .center) {
                    if person.personAvatarKey != nil, avatar == nil {
                        PersonAvatarView(imageKey: person.personAvatarKey, style: .medium)
                    }
                    if avatar != nil {
                        EWAvatarImage(avatar: avatar!, style: .medium)
                    }

                    EWAvatarAdd(avatar: $avatar, style: .medium)
                        .foregroundColor(.ewGray900)
                }

                // MARK: - TODO

                EWTextField(input: $person.titleOrName ?? "", icon: nil, placeholder: "Name")
            }
            EWTextFieldMultiline(input: $person.description ?? "", placeholder: "Description")
        }
    }
}

struct EWCardPersonEditor_Previews: PreviewProvider {
    @State static var person: AmplifyCommit = .init(commitType: .person)
    @State static var image: UIImage?
    static var previews: some View {
        CommitPersonEditor(person: $person, avatar: $image)
            .previewLayout(.sizeThatFits)
    }
}
