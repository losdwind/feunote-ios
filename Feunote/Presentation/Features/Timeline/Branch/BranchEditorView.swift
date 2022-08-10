//
//  BranchCardEditingView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/28.
//

import SwiftUI

import Kingfisher

extension BranchEditorView {
    class ViewModel: ObservableObject {
        internal init(branch: AmplifyBranch, saveBranchUseCase: SaveBranchUseCaseProtocol, getProfilesByIDsUseCase: GetProfilesByIDsUseCaseProtocol) {
            self.branch = branch
            self.saveBranchUseCase = saveBranchUseCase
            self.getProfilesByIDsUseCase = getProfilesByIDsUseCase
        }

        private var saveBranchUseCase: SaveBranchUseCaseProtocol

        private var getProfilesByIDsUseCase: GetProfilesByIDsUseCaseProtocol

        @Published var branch: AmplifyBranch

        @Published var fetchedAmplifyUsers: [AmplifyUser] = []
        @Published var fetchedAllCommits: [AmplifyCommit] = []

        @Published var searchInput: String = ""

        @Published var hasError = false
        @Published var appError: AppError?

        // MARK: Upload AmplifyBranch

        func saveBranch() {
            Task {
                do {
                    if self.branch.title == "" {
                        throw AppError.invalidSubmit
                    }
                    try await saveBranchUseCase.execute(branch: branch)
                } catch {
                    hasError = true
                    appError = error as? AppError
                }
            }
        }

        func getMembersByIDs(userIDs: [String]) async {
            do {
                fetchedAmplifyUsers = try await getProfilesByIDsUseCase.execute(userIDs: userIDs)

            } catch {
                hasError = true
                appError = error as? AppError
            }
        }
    }
}

struct BranchEditorView: View {
    init(branch: AmplifyBranch, saveBranchUseCase: SaveBranchUseCaseProtocol = SaveBranchUseCase(), getPRofilesByIDsUsecase: GetProfilesByIDsUseCaseProtocol = GetProfilesByIDsUseCase()) {
        _viewModel = StateObject(wrappedValue: ViewModel(branch: branch, saveBranchUseCase: saveBranchUseCase, getProfilesByIDsUseCase: getPRofilesByIDsUsecase))
    }

    @StateObject var viewModel: ViewModel

    @Environment(\.dismiss) var dismiss

    // Show Picker..
    @State var showDatePicker = false

    @State var isShowingAddCollaboratorView: Bool = false

    @State var searchInput: String = ""

    var membersAvatarKeys: [String?] {
        viewModel.branch.actions?.filter { $0.actionType == ActionType.participate.rawValue }.map { action in
            action.creator.avatarKey
        } ?? []
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
            EWTextField(input: $viewModel.branch.title, icon: nil, placeholder: "Title")

            EWTextFieldMultiline(input: $viewModel.branch.description, placeholder: "Description")

            EWPicker(selected: $viewModel.branch.privacyType, title: "Privacy")

            VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                Text("Select Colloborators")
                    .font(.ewHeadline)
                    .foregroundColor(.ewGray900)

                HStack(spacing: .ewPaddingVerticalDefault) {
                    if membersAvatarKeys != nil {
                        ForEach(membersAvatarKeys, id: \.self) { key in
                            PersonAvatarView(imageKey: key)
                        }
                    }
                    Spacer()
                    EWButton(text: "Add \(membersAvatarKeys.count)/5", image: nil, style: .secondaryCapsule) {
                        isShowingAddCollaboratorView.toggle()
                    }
                }
            }

            EWButton(text: "Save", image: nil, style: .primarySmall) {
                viewModel.saveBranch()
                dismiss()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()

        if isShowingAddCollaboratorView {
            SearchView(input: $searchInput)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .background(Color.white)
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
