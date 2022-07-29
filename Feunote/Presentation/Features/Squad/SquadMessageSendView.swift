//
//  SquadMessageSendView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/23.
//

import SwiftUI

struct SquadMessageSendView: View {
    @EnvironmentObject var squadvm:SquadViewModel
    @State var content:String = ""
    var branch:AmplifyBranch
    var body: some View {

        HStack {
//            EWTextFieldMultiline(input: $content, placeholder: "Message")

            EWTextField(input: $content, icon: nil, placeholder: "Message")
            EWButton(text: "Send", style: .primarySmall) {
                Task {
                    await squadvm.sendAction(branchID: branch.id, actionType: .message, content: content)
                    print("message submitted")
                    content = ""
                }
            }

        }
        .frame(maxWidth:.infinity, maxHeight:80)
    }
}

struct SquadMessageSendView_Previews: PreviewProvider {
    static var previews: some View {
        SquadMessageSendView(branch: AmplifyBranch(privacyType: .open, title: "demo branch title", description: "demo branch descripttion"))
    }
}
