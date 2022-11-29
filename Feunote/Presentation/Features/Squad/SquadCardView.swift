//
//  SquadCardView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import SwiftUI
import Combine
extension SquadCardView {
    @MainActor
    class ViewModel: ObservableObject {
        init(branch: Binding<AmplifyBranch>, getMessagesUseCase: GetMessagesUseCaseProtocol, getBranchMembersUseCase: GetBranchMembersUseCaseProtocol, subscribeMessagesUseCase: SubscribeMessagesUseCaseProtocol, saveMessageUseCase: SaveMessageUseCaseProtocol, deleteMessageUseCase: DeleteMessageUseCaseProtocol) {
            self._branch = branch
            self.getMessagesUseCase = getMessagesUseCase
            self.getBranchMembersUseCase = getBranchMembersUseCase
            self.subscribeMessagesUseCase = subscribeMessagesUseCase
            self.saveMessageUseCase = saveMessageUseCase
            self.deleteMessageUseCase = deleteMessageUseCase

        }

        private var getMessagesUseCase: GetMessagesUseCaseProtocol
        private var getBranchMembersUseCase: GetBranchMembersUseCaseProtocol
        private var saveMessageUseCase: SaveMessageUseCaseProtocol
        private var deleteMessageUseCase: DeleteMessageUseCaseProtocol
        private var subscribeMessagesUseCase: SubscribeMessagesUseCaseProtocol

        @Binding var branch: AmplifyBranch
        @Published var fetchedMessages: [AmplifyMessage] = []
        @Published var fetchedMembers: [AmplifyUser] = []

        @Published var hasError = false
        @Published var appError: Error?

        private var subscribers = Set<AnyCancellable>()


        func sendMessage(content: String) {
            Task {
                do {
                    let message = try await saveMessageUseCase.execute(branchID: branch.id, content: content)
                    DispatchQueue.main.async {
                        self.fetchedMessages.append(message)
                    }
                } catch {
                    hasError = true
                    appError = error as? Error
                }
            }
        }

        func subscribeMessages() {
            subscribeMessagesUseCase.execute(branchID: branch.id, page: 0).sink {
                if case let .failure(error) = $0 {
                    print("Got failed event with error \(error)")
                    self.hasError = true
                    self.appError = error as? Error
                }
            } receiveValue: {
                querySnapshot in
                print("fetched messages: \(querySnapshot.items.count), isSynced: \(querySnapshot.isSynced)")
                DispatchQueue.main.async {
//                    print("querysnapshot for messages\(querySnapshot.items)")
                    self.fetchedMessages = querySnapshot.items
                }
            }
            .store(in: &subscribers)
        }


        func getMessages() async {
                do {
                    let messages = try await getMessagesUseCase.execute(branchID: branch.id)
                    DispatchQueue.main.async {
                        self.fetchedMessages = messages
                    }

                } catch {
                    hasError = true
                    appError = error as? Error
                }

        }

        func getMembers() async {
                do {
                    let members = try await getBranchMembersUseCase.execute(branchID: branch.id)

                    DispatchQueue.main.async {
                        self.fetchedMembers = members
                    }

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

    init(branch: Binding<AmplifyBranch>, getMessagesUseCase: GetMessagesUseCaseProtocol = GetMessagesUseCase(), getBranchMembersUseCase: GetBranchMembersUseCaseProtocol = GetBranchMembersUseCase(), subscribeMessagesUseCase:SubscribeMessagesUseCaseProtocol = SubscribeMessagesUseCase(), saveMessageUseCase: SaveMessageUseCaseProtocol = SaveMessageUseCase(), deleteMessageUseCase: DeleteMessageUseCaseProtocol = DeleteMessageUseCase()) {
        _viewModel = StateObject(wrappedValue: ViewModel(branch: branch, getMessagesUseCase: getMessagesUseCase, getBranchMembersUseCase: getBranchMembersUseCase, subscribeMessagesUseCase:subscribeMessagesUseCase, saveMessageUseCase: saveMessageUseCase, deleteMessageUseCase: deleteMessageUseCase))
    }


    @State var content: String = ""

    var body: some View {
        NavigationLink {
            SquadChatView(viewModel: viewModel)
        } label: {
            VStack(alignment: .leading, spacing: .ewCornerRadiusDefault) {
                HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
                    HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
                        ForEach(viewModel.fetchedMembers.map { $0.avatarKey }, id: \.self) { avatarKey in
                            PersonAvatarView(imageKey: avatarKey, style: .small)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text(viewModel.branch.squadName ?? "No Name")
                        .font(.headline)
                        .foregroundColor(.ewBlack)
                        .lineLimit(1)
                }

                if let latestMessage = viewModel.fetchedMessages.last {
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
            await viewModel.getMembers()
        }
        .onAppear{
            viewModel.subscribeMessages()
        }
        .padding()
    }
}

struct SquadCardView_Previews: PreviewProvider {
    @State static var fakeAmplifyBranchOpen1: AmplifyBranch = fakeAmplifyBranchOpen1
    static var previews: some View {
        SquadCardView(branch: $fakeAmplifyBranchOpen1)
    }
}
