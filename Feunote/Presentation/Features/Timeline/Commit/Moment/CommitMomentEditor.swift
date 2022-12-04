//
//  CardMomentEditor.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/10.
//

import SwiftUI

struct CommitMomentEditor: View {
    @Binding var moment: AmplifyCommit
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
            EWTextField(input: $moment.titleOrName ?? "", icon: nil, placeholder: "Title")
            EWTextFieldMultiline(input: $moment.description ?? "", placeholder: "Description")

        }
    }
}

struct EWCardMomentEditor_Previews: PreviewProvider {
    @State static var moment: AmplifyCommit = .init(commitType: .moment)
    @State static var images: [UIImage] = []
    static var previews: some View {
        CommitMomentEditor(moment: $moment)
    }
}
