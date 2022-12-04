//
//  BranchCardEditingView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/28.
//

import SwiftUI

import Kingfisher
import PartialSheet

extension BranchEditorView {
    @MainActor
    class ViewModel: ObservableObject {
        internal init(branch: AmplifyBranch, saveBranchUseCase: SaveBranchUseCaseProtocol, getProfilesByIDsUseCase: GetProfilesByIDsUseCaseProtocol, getUserByUsernameUseCase: GetUserByUsernameUseCaseProtocol, addParticipantsHackerWayUseCase: AddParticipantHackerWayUseCaseProtocol) {
            self.branch = branch
            self.saveBranchUseCase = saveBranchUseCase
            self.getProfilesByIDsUseCase = getProfilesByIDsUseCase
            self.getUserByUsernameUseCase = getUserByUsernameUseCase
            self.addParticipantsHackerWayUseCase = addParticipantsHackerWayUseCase
        }

        private var saveBranchUseCase: SaveBranchUseCaseProtocol

        private var getProfilesByIDsUseCase: GetProfilesByIDsUseCaseProtocol

        private var getUserByUsernameUseCase: GetUserByUsernameUseCaseProtocol

        private var addParticipantsHackerWayUseCase: AddParticipantHackerWayUseCaseProtocol

        @Published var branch: AmplifyBranch

        @Published var fetchedAmplifyUsers: [AmplifyUser?] = []
        @Published var fetchedAllCommits: [AmplifyCommit] = []

        @Published var searchInput: String = ""
        @Published var searchUserResult: AmplifyUser?
        @Published var pendingAddMembers: [AmplifyUser] = []
        @Published var isShowingAddCollaboratorView:Bool = false

        @Published var hasError = false
        @Published var appError: Error?

        // MARK: Upload AmplifyBranch

        func saveBranch() {
            Task {
                do {
                    if self.branch.title == "" {
                        throw AppError.invalidSubmit
                    }
                    try await saveBranchUseCase.execute(branch: branch)
                    if !pendingAddMembers.isEmpty {
                        try await self.addParticipantsHackerWayUseCase.execute(targetUsers: pendingAddMembers, branchID: branch.id)
                    }
                    playSound(sound: "sound-ding", type: "mp3")
                    branch = AmplifyBranch(privacyType: .private, title: "", description: "")
                } catch {
                    hasError = true
                    appError = error as? Error
                }
            }
        }

        func getMembersByIDs(userIDs: [String]) async {
            do {
                fetchedAmplifyUsers = try await getProfilesByIDsUseCase.execute(userIDs: userIDs)

            } catch {
                hasError = true
                appError = error as? Error
            }
        }

        func getUserByUsername(username: String) async {
            do {
                self.searchUserResult = try await getUserByUsernameUseCase.execute(username: username)
            } catch {
                hasError = true
                appError = error as? Error
            }
        }
    }
}

struct BranchEditorView: View {

    init(branch: AmplifyBranch, saveBranchUseCase: SaveBranchUseCaseProtocol = SaveBranchUseCase(), getPRofilesByIDsUsecase: GetProfilesByIDsUseCaseProtocol = GetProfilesByIDsUseCase(), getUserByUsernameUseCase: GetUserByUsernameUseCaseProtocol = GetUserByUsernameUseCase(), addParticipantsHackerWayUseCase: AddParticipantHackerWayUseCaseProtocol = AddParticipantHackerWayUseCase()) {
        _viewModel = StateObject(wrappedValue: ViewModel(branch: branch, saveBranchUseCase: saveBranchUseCase, getProfilesByIDsUseCase: getPRofilesByIDsUsecase, getUserByUsernameUseCase: getUserByUsernameUseCase, addParticipantsHackerWayUseCase: addParticipantsHackerWayUseCase))
    }

    @StateObject var viewModel: ViewModel

    @Environment(\.dismiss) var dismiss

    // Show Picker..
    @State var showDatePicker = false


    @State var searchInput: String = ""

    @State var toggleState: Bool = false

    var membersAvatarKeys: [String?] {
        viewModel.branch.actions?.filter { $0.actionType == ActionType.participate.rawValue }.map { action in
            action.creator.avatarKey
        } ?? []
    }

    var body: some View {

            // Add Member
            if viewModel.isShowingAddCollaboratorView {
                VStack {
                    HStack(alignment: .center, spacing: .ewPaddingVerticalDefault) {
                        ForEach(viewModel.pendingAddMembers, id: \.username) { member in
                            PersonAvatarView(imageKey: member.avatarKey)
                        }
                    }
                    HStack {
                        EWTextField(input: $viewModel.searchInput, icon: nil, placeholder: "search with username")
                        EWButton(image: Image("search"), style: .primarySmall, action: {
                            Task {
                                await viewModel.getUserByUsername(username: viewModel.searchInput)
                            }
                        })
                    }

                    if viewModel.searchUserResult != nil {
                        HStack(alignment: .top, spacing: .ewPaddingHorizontalSmall) {
                            PersonAvatarView(imageKey: viewModel.searchUserResult!.avatarKey)
                            VStack(alignment: .leading, spacing: .ewPaddingVerticalSmall) {
                                Text(viewModel.searchUserResult!.nickName ?? "Empty").font(.ewHeadline).foregroundColor(.ewPrimaryBase)
                                Text(viewModel.searchUserResult!.username ?? "Error").font(.ewFootnote).foregroundColor(.ewGray900)
                                HStack {
                                    Image("shield").foregroundColor(.ewPrimaryBase)
                                    Text(viewModel.searchUserResult!.wellbeingIndex ?? "673").font(.ewFootnote).foregroundColor(.ewSecondaryBase)
                                }
                            }
                            .onTapGesture {
                                viewModel.pendingAddMembers.append(viewModel.searchUserResult!)
                                viewModel.searchUserResult = nil
                                viewModel.searchInput = ""
                            }
                        }
                        .frame(maxWidth:.infinity,alignment: .leading)

                    }

                    HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge) {
                        EWButton(text: "Cancel",style: .secondarySmall, action: {
                            viewModel.pendingAddMembers = []
                            viewModel.isShowingAddCollaboratorView = false
                        })
                        Spacer()
                        EWButton(text: "Invite",style: .primarySmall, action: {
                            viewModel.isShowingAddCollaboratorView = false
                        })
                    }
                }
                .padding(.ewPaddingHorizontalDefault)
                .padding(.ewPaddingVerticalDefault)

            } else {

                // Editor
                VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
                    EWTextField(input: $viewModel.branch.title, icon: nil, placeholder: "Title")

                    EWTextFieldMultiline(input: $viewModel.branch.description, placeholder: "Description")

                    if membersAvatarKeys != nil {
                        HStack(spacing: .ewPaddingHorizontalDefault) {
                            if membersAvatarKeys != nil {
                                ForEach(membersAvatarKeys, id: \.self) { key in
                                    PersonAvatarView(imageKey: key)
                                }
                            }
                        }
                    }

                    HStack {
                        HStack {
                            Text("Public")
                                .font(.ewHeadline).foregroundColor(.ewGray900)
                            EWToggle(toggleState: $toggleState, title: "Is Public")
                                .onAppear() {
                                    toggleState = viewModel.branch.privacyType == PrivacyType.private ? false : true
                                }
                        }
                        Spacer()
                        EWButton(text: "\(membersAvatarKeys.count)/5", image: Image("user"), style: .secondaryCapsule) {
                            viewModel.isShowingAddCollaboratorView = true
                        }
                        Spacer()
                        EWButton(text: "Save", image: nil, style: .primarySmall) {
                            viewModel.branch.privacyType = toggleState ? PrivacyType.open : PrivacyType.private
                            viewModel.saveBranch()
                            dismiss()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.ewPaddingHorizontalDefault)
                .padding(.ewPaddingVerticalDefault)

        }

    }



}

// Meeting tab Button...
struct OpenessTabButton: View {
    var title: String

    @Binding var currentType: String

    var body: some View {
        Button {
            withAnimation {
                currentType = title
            }

        } label: {
            Text(title)
                .font(.footnote)
                .foregroundColor(title != currentType ? .ewBlack : .white)
                .padding(.vertical, 8)
                // Max Width...
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .stroke(Color.ewBlack, lineWidth: 1)
                )
                .background(
                    Capsule()
                        .fill(Color.ewBlack.opacity(title == currentType ? 1 : 0))
                )
        }
    }
}

// Custom Date Picker...
struct CustomDatePicker: View {
    @Binding var date: Date
    @Binding var showPicker: Bool

    var body: some View {
        ZStack {
            // Blur Effect...
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()

            DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()

            // Close Button...
            Button {
                withAnimation {
                    showPicker.toggle()
                }

            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(.gray, in: Circle())
            }
            .padding(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .opacity(showPicker ? 1 : 0)
    }
}

struct BranchCardEditorView_Previews: PreviewProvider {
    static var previews: some View {
        BranchEditorView(branch: AmplifyBranch(privacyType: .private, title: "", description: ""))
    }
}
