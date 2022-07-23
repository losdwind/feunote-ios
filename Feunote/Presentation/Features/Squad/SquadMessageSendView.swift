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
    var branchID:String
    var body: some View {

        ZStack {
            EWTextFieldMultiline(input: $content, placeholder: "Message")
            EWButton(text: "Send", image: Image("send-2"), style: .primarySmall) {
                task {
                    print("message submitted")
                    await squadvm.sendAction(branchID: branchID, actionType: .message, content: content)
                }
            }
        }
        .frame(maxWidth:.infinity, maxHeight:80)
    }
}

struct SquadMessageSendView_Previews: PreviewProvider {
    static var previews: some View {
        SquadMessageSendView(branchID: "")
    }
}
