//
//  Cards.swift
//  BricksUI
//
//  Created by Samuel Kebis on 11/05/2020.
//  Copyright © 2020 Fabio Staiano. All rights reserved.
//

import SwiftUI

extension BranchView {
    class ViewModel: ObservableObject {
        internal init(branch: AmplifyBranch, saveActionUseCase: SaveActionUseCaseProtocol, deleteActionUseCase: DeleteActionUseCaseProtocol, getBranchMembersUseCase: GetBranchMembersUseCaseProtocol) {
            self.branch = branch
            self.saveActionUseCase = saveActionUseCase
            self.deleteActionUseCase = deleteActionUseCase
            self.getBranchMembersUseCase = getBranchMembersUseCase
        }

        private var saveActionUseCase: SaveActionUseCaseProtocol
        private var deleteActionUseCase: DeleteActionUseCaseProtocol
        private var getBranchMembersUseCase: GetBranchMembersUseCaseProtocol

        @Published var branch: AmplifyBranch
        @Published var members: [AmplifyUser] = []

        @Published var hasError = false
        @Published var appError: Error?

        func sendAction(actionType: ActionType) {
            Task {
                do {
                    try await saveActionUseCase.execute(branchID: branch.id, actionType: actionType, content: nil)

                } catch {
                    hasError = true
                    appError = error as? Error
                }
            }
        }

        func getBranchMembers() {
            Task {
                do {
                    self.members = try await getBranchMembersUseCase.execute(branchID: branch.id)
                } catch {
                    hasError = true
                    appError = error as? Error
                }
            }
        }
    }
}

struct BranchView: View {
    @StateObject var viewModel: ViewModel
    @State var isShowingCommentsView: Bool = false

    init(branch: AmplifyBranch, saveActionUseCase: SaveActionUseCaseProtocol = SaveActionUseCase(), deleteActionUseCase: DeleteActionUseCaseProtocol = DeleteActionUseCase(), getBranchMembersUseCase: GetBranchMembersUseCaseProtocol = GetBranchMembersUseCase()) {
        _viewModel = StateObject(wrappedValue: ViewModel(branch: branch, saveActionUseCase: saveActionUseCase, deleteActionUseCase: deleteActionUseCase, getBranchMembersUseCase: getBranchMembersUseCase))
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
                        Label(formatNumber(viewModel.branch.numOfLikes ?? 0), image: "like")
                    }

                    Button {
                        viewModel.sendAction(actionType: .sub)
                    } label: {
                        Label(formatNumber(viewModel.branch.numOfSubs ?? 0), image: "rate-full")
                    }

                    Button {
                        viewModel.sendAction(actionType: .share)

                    } label: {
                        Label(formatNumber(viewModel.branch.numOfShares ?? 0), image: "replay-2")
                    }

                    Button {
                        isShowingCommentsView.toggle()
                    } label: {
                        Label(formatNumber(viewModel.branch.numOfComments ?? 0), image: "messaging")
                    }
                }
                .partialSheet(isPresented: $isShowingCommentsView) {
                    BranchCommentsView(branch: viewModel.branch)
                }
                .font(.ewFootnote)
            }
        }
        .padding(.horizontal, .ewPaddingHorizontalDefault)
        .padding(.vertical, .ewPaddingVerticalDefault)
        .background(Color.ewGray50)
        .cornerRadius(.ewCornerRadiusDefault)
    }
}

struct BranchView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BranchView(branch: AmplifyBranch(privacyType: .open, title: "", description: ""))
        }
        .previewLayout(.fixed(width: 300, height: 330))
    }
}
