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
    var branchID:String
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                    ForEach(squadvm.fetchedCurrentBranchMessages, id:\.id){ message in
                        SquadMessageView(message: message)
                    }
                }
            }
            
            SquadMessageSendView(branchID: branchID)

        }

            .padding()

        .navigationBarBackButtonHidden(true)
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
                } label: {
                    Image("more-hor")
                        .foregroundColor(.ewBlack)
                }
                .menuStyle(.automatic)


            }
        }
        .task {
            await squadvm.getMessages(branchID: branchID)
        }
    }
}

struct SquadChatView_Previews: PreviewProvider {
    static var previews: some View {
        SquadChatView(branchID: "")
    }
}
