//
//  Cards.swift
//  BricksUI
//
//  Created by Samuel Kebis on 11/05/2020.
//  Copyright © 2020 Fabio Staiano. All rights reserved.
//

import SwiftUI

extension BranchCardView {
    class ViewModel: ObservableObject {
        internal init(branch: AmplifyBranch, saveActionUseCase: SaveActionUseCaseProtocol, deleteActionUseCase: DeleteActionUseCaseProtocol, getBranchMembersUseCase: GetBranchMembersUseCaseProtocol, getCurrentUserUseCase: GetCurrentProfileUseCaseProtocol, getBranchByIDUseCase: GetBranchByIDUseCaseProtocol) {
            self.branch = branch
            self.saveActionUseCase = saveActionUseCase
            self.deleteActionUseCase = deleteActionUseCase
            self.getBranchMembersUseCase = getBranchMembersUseCase
            self.getCurrentUserUseCase = getCurrentUserUseCase
            self.getBranchByIDUseCase = getBranchByIDUseCase
        }

        private var saveActionUseCase: SaveActionUseCaseProtocol
        private var deleteActionUseCase: DeleteActionUseCaseProtocol
        private var getBranchMembersUseCase: GetBranchMembersUseCaseProtocol
        private var getCurrentUserUseCase: GetCurrentProfileUseCaseProtocol
        private var getBranchByIDUseCase: GetBranchByIDUseCaseProtocol

        @Published var branch: AmplifyBranch
        @Published var members: [AmplifyUser] = []
        @Published var currentUser: AmplifyUser = .init()

        @Published var hasError = false
        @Published var appError: Error?

        func refreshBranch() async {
            do {
                let newBranch = try await getBranchByIDUseCase.execute(branchID: branch.id)
                DispatchQueue.main.async {
                    if newBranch != nil {
                        self.branch = newBranch!
                    }
                }

            } catch {
                hasError = true
                appError = error as? Error
            }
        }

        func sendAction(actionType: ActionType) {
            Task {
                do {
                    if let existedAction = branch.actions?.first(where: { ($0.creator.id == currentUser.id) && ($0.actionType == actionType.rawValue) }) {
                        try await deleteActionUseCase.execute(action: existedAction)
                    } else {
                        try await saveActionUseCase.execute(branchID: branch.id, actionType: actionType, content: nil)
                    }

                    await self.getCurrentUser()
                    await self.refreshBranch()

                } catch {
                    hasError = true
                    appError = error as? Error
                }
            }
        }

        func getCurrentUser() async {
            do {
                let user = try await getCurrentUserUseCase.execute() ?? AmplifyUser()
                DispatchQueue.main.async {
                    self.currentUser = user
                }

            } catch {
                hasError = true
                appError = error as? Error
            }
        }

        func getBranchMembers() async {
            do {
                let branchMembers = try await getBranchMembersUseCase.execute(branchID: branch.id)
                DispatchQueue.main.async {
                    self.members = branchMembers
                }
            } catch {
                hasError = true
                appError = error as? Error
            }
        }
    }
}

struct BranchCardView: View {
    @StateObject var viewModel: ViewModel
    @State var isShowingCommentsView: Bool = false

    init(branch: AmplifyBranch, saveActionUseCase: SaveActionUseCaseProtocol = SaveActionUseCase(), deleteActionUseCase: DeleteActionUseCaseProtocol = DeleteActionUseCase(), getBranchMembersUseCase: GetBranchMembersUseCaseProtocol = GetBranchMembersUseCase(), getCurrentUserUseCase: GetCurrentProfileUseCaseProtocol = GetCurrentProfileUseCase(), getBranchByIDUseCase: GetBranchByIDUseCaseProtocol = GetBranchByIDUseCase()) {
        _viewModel = StateObject(wrappedValue: ViewModel(branch: branch, saveActionUseCase: saveActionUseCase, deleteActionUseCase: deleteActionUseCase, getBranchMembersUseCase: getBranchMembersUseCase, getCurrentUserUseCase: getCurrentUserUseCase, getBranchByIDUseCase: getBranchByIDUseCase))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
            VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                Text(viewModel.branch.title)
                    .font(Font.ewHeadline)
                    .lineLimit(1)

                Text(viewModel.branch.description)
                    .font(Font.ewBody)
                    .foregroundColor(Color.ewGray900)
                    .multilineTextAlignment(.leading)
                    .lineLimit(viewModel.branch.privacyType == .open ? 5 : 10)
            }

            if viewModel.branch.privacyType == .open {
                HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
                    ForEach(viewModel.members, id: \.id) { member in
                        PersonAvatarView(imageKey: member.avatarKey)
                    }
                }
            }

            if viewModel.branch.privacyType == .open {
                HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall) {
                    Button {
                        viewModel.sendAction(actionType: .like)
                    } label: {
                        Label(formatNumber(viewModel.branch.actions?.filter { $0.actionType == ActionType.like.rawValue }.count ?? 0), image: "like").foregroundColor(viewModel.currentUser.actions?.filter { ($0.toBranch.id == viewModel.branch.id) && ($0.actionType == ActionType.like.rawValue) }.isEmpty ?? false ? .ewGray900 : .ewSecondaryBase)
                    }

                    Button {
                        viewModel.sendAction(actionType: .sub)
                    } label: {
                        Label(formatNumber(viewModel.branch.actions?.filter { $0.actionType == ActionType.sub.rawValue }.count ?? 0), image: "rate-full")
                            .foregroundColor(viewModel.currentUser.actions?.filter { ($0.toBranch.id == viewModel.branch.id) && ($0.actionType == ActionType.sub.rawValue) }.isEmpty ?? false ? .ewGray900 : .ewSecondaryBase)
                    }

                    Button {
                        viewModel.sendAction(actionType: .share)

                    } label: {
                        Label(formatNumber(viewModel.branch.actions?.filter { $0.actionType == ActionType.share.rawValue }.count ?? 0), image: "replay-2")
                            .foregroundColor(viewModel.currentUser.actions?.filter { ($0.toBranch.id == viewModel.branch.id) && ($0.actionType == ActionType.share.rawValue) }.isEmpty ?? false ? .ewGray900 : .ewSecondaryBase)
                    }

                    Button {
                        isShowingCommentsView.toggle()
                    } label: {
                        Label(formatNumber(viewModel.branch.comments?.count ?? 0), image: "messaging")
                            .foregroundColor(viewModel.currentUser.comments?.filter { $0.toBranch.id == viewModel.branch.id }.isEmpty ?? false ? .ewGray900 : .ewSecondaryBase)
                    }
                }
                .partialSheet(isPresented: $isShowingCommentsView) {
                    BranchCommentsView(branch: viewModel.branch)
                }
                .font(.ewFootnote)
            }
        }
        .task {
            await viewModel.getBranchMembers()
            await viewModel.getCurrentUser()
        }
        .frame(maxWidth: 640, alignment: .leading)
        .padding(.horizontal, .ewPaddingHorizontalDefault)
        .padding(.vertical, .ewPaddingVerticalDefault)
        .background(Color.ewGray50)
        .cornerRadius(.ewCornerRadiusDefault)
    }
}

struct BranchView_Previews: PreviewProvider {
    static var branch = AmplifyBranch(privacyType: .open, title: "", description: "")
    static var previews: some View {
        VStack {
            BranchCardView(branch: branch)
        }
        .previewLayout(.fixed(width: 300, height: 330))
    }
}
