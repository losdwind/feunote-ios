//
//  SquadChatView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/23.
//

import SwiftUI

struct SquadChatView: View {
    @EnvironmentObject var squadvm:SquadViewModel
    @Environment(\.presentationMode) var presentationMode
    var branch:AmplifyBranch
    var messages:[AmplifyAction] {
        branch.actions?.elements.filter({$0.actionType == ActionType.message.rawValue}) ?? []
    }
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                    ForEach(messages, id:\.id){ message in
                        SquadMessageView(message: message)
                    }
                }
            }
            
            SquadMessageSendView(branch: branch)
                .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .bottom)

        }

        .padding()

        .navigationBarBackButtonHidden(true)
        .navigationTitle(Text(branch.squadName ?? "No Name"))
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()

                } label: {
                    Image("arrow-left-2")
                        .foregroundColor(.ewBlack)
                }


            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button("Duplicate", action: {})
                    Button("Rename", action: {})
                    Button("Delete…", action: {})
                } label: {
                    Image("more-hor")
                    .foregroundColor(.ewBlack)
                }


            }
        }
    }
}

struct SquadChatView_Previews: PreviewProvider {
    static var previews: some View {
        SquadChatView(branch: fakeAmplifyBranchOpen1)
    }
}
