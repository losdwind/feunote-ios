//
//  SquadCardView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import SwiftUI

extension SquadCardView {
    @MainActor
    class ViewModel: ObservableObject {
        init(branch: AmplifyBranch, getMessagesUseCase: GetMessagesUseCaseProtocol, getBranchMembersUseCase:GetBranchMembersUseCaseProtocol) {
            self.branch = branch
            self.getMessagesUseCase = getMessagesUseCase
            self.getBranchMembersUseCase = getBranchMembersUseCase

        }

        private var getMessagesUseCase: GetMessagesUseCaseProtocol
        private var getBranchMembersUseCase:GetBranchMembersUseCaseProtocol

        @Published var branch: AmplifyBranch
        @Published var fetchedMessages: [AmplifyAction] = []
        @Published var fetchedMembers:[AmplifyUser] = []


        @Published var hasError = false
        @Published var appError: Error?

        func getMessages() async {
            do {
                self.fetchedMessages = try await getMessagesUseCase.execute(branchID: branch.id)
            } catch {
                hasError = true
                appError = error as? Error
            }
        }

        func getMembers() async {
            do {
                self.fetchedMembers = try await getBranchMembersUseCase.execute(branchID: branch.id)
            } catch {
                hasError = true
                appError = error as? Error
            }
        }

    }
}

struct SquadCardView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var viewModel: ViewModel

    init(branch: AmplifyBranch, getMessagesUseCase: GetMessagesUseCaseProtocol = GetMessagesUseCase(), getBranchMembersUseCase:GetBranchMembersUseCaseProtocol = GetBranchMembersUseCase()) {
        _viewModel = StateObject(wrappedValue: ViewModel(branch: branch, getMessagesUseCase: getMessagesUseCase, getBranchMembersUseCase: getBranchMembersUseCase))
    }

    @State var content: String = ""

    var body: some View {
        NavigationLink {
            SquadChatView(branch: viewModel.branch, messages: viewModel.fetchedMessages)
        } label: {
            VStack(alignment: .leading, spacing: .ewCornerRadiusDefault) {
                HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
                    HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault){
                        ForEach(viewModel.fetchedMembers.map{$0.avatarKey}, id:\.self){ avatarKey in
                            PersonAvatarView(imageKey: avatarKey,style: .small)
                        }
                    }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(viewModel.branch.squadName ?? "No Name")
                        .font(.headline)
                        .foregroundColor(.ewBlack)
                        .lineLimit(1)
                }

                if let latestMessage = viewModel.fetchedMessages.first {
                    HStack {
                        Text(latestMessage.creator.nickName ?? "Anonymous")
                            .font(.subheadline)
                            .foregroundColor(.ewBlack)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(latestMessage.createdAt?.foundationDate.formatted(date: .omitted, time: .shortened).description ?? Date.now.formatted(date: .omitted, time: .shortened).description)
                    }

                    Text(latestMessage.content ?? "")
                        .lineLimit(1)
                        .font(.ewFootnote)
                        .foregroundColor(.ewGray900)
                }
            }
        }
        .task {
            await viewModel.getMessages()
            await viewModel.getMembers()
        }
        .padding()
    }
}

struct SquadCardView_Previews: PreviewProvider {
    static var previews: some View {
        SquadCardView(branch: fakeAmplifyBranchOpen1)
    }
}
