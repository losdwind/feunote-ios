//
//  SquadChatView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/23.
//

import SwiftUI

struct SquadChatView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: SquadCardView.ViewModel

    @State var content: String = ""

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                    ForEach(viewModel.fetchedMessages, id: \.id) { message in
                        SquadMessageView(message: message,imageKey: viewModel.fetchedMembers.first(where: {$0.id == message.creator.id})?.avatarKey ?? "")
                    }
                }
            }

            HStack {
                EWTextField(input: $content, icon: nil, placeholder: "Message")
                EWButton(text: "Send", style: .primarySmall) {
                    viewModel.sendMessage(content: content)
                    content = ""
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 80, alignment: .bottom)
        }

        .padding()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()

                } label: {
                    Image("arrow-left-2")
                        .foregroundColor(.ewGray900)
                }
            }

            ToolbarItem(placement: .principal) {
                Text(viewModel.branch.squadName ?? "No Name")
                    .font(.ewHeadline)
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

//struct SquadChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        SquadChatView(branch: fakeAmplifyBranchOpen1, messages: [fakeActionMessage1, fakeActionMessage2], viewModel: SquadCardView.ViewModel())
//    }
//}
