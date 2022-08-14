//
//  SquadChatView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/23.
//

import SwiftUI

extension SquadChatView {
    @MainActor
    class ViewModel: ObservableObject {
        init(branch: AmplifyBranch,messages:[AmplifyAction], saveActionUseCase: SaveActionUseCaseProtocol, deleteActionUseCase: DeleteActionUseCaseProtocol) {
            self.branch = branch
            self.messages = messages
            self.saveActionUseCase = saveActionUseCase
            self.deleteActionUseCase = deleteActionUseCase
        }

        private var saveActionUseCase: SaveActionUseCaseProtocol
        private var deleteActionUseCase: DeleteActionUseCaseProtocol

        @Published var branch: AmplifyBranch
        @Published var messages: [AmplifyAction]

        @Published var hasError = false
        @Published var appError: Error?

        func sendMessage(content: String) {
            Task {
                do {
                    try await saveActionUseCase.execute(branchID: branch.id, actionType: .message, content: content)
                } catch {
                    hasError = true
                    appError = error as? Error
                }
            }
        }
    }
}

struct SquadChatView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var viewModel: ViewModel

    init(branch: AmplifyBranch, messages:[AmplifyAction], saveActionUseCase: SaveActionUseCaseProtocol = SaveActionUseCase(), deleteActionUseCase: DeleteActionUseCaseProtocol = DeleteActionUseCase()) {
        _viewModel = StateObject(wrappedValue: ViewModel(branch: branch, messages: messages, saveActionUseCase: saveActionUseCase, deleteActionUseCase: deleteActionUseCase))
    }

    @State var content: String = ""

    var body: some View {

        ZStack(alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                    ForEach(viewModel.messages, id: \.id) { message in
                        SquadMessageView(message: message)
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
                        .foregroundColor(.ewBlack)
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

struct SquadChatView_Previews: PreviewProvider {
    static var previews: some View {
        SquadChatView(branch: fakeAmplifyBranchOpen1, messages: [fakeActionMessage1, fakeActionMessage2])
    }
}
