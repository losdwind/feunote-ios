//
//  BranchConnectView.swift
//  Feunote
//
//  Created by Losd wind on 2022/11/27.
//

import Amplify
import PartialSheet
import SwiftUI
extension BranchConnectView {
    @MainActor
    class ViewModel: ObservableObject {
        internal init(commit: AmplifyCommit, connectBranchUseCase: ConnectBranchUseCaseProtocol, getParticipatedBranchesUseCase: GetParticipatedBranchesUseCaseProtocol, getOwnedBranchesUseCase: GetOwnedBranchesUseCase) {
            self.connectBranchUseCase = connectBranchUseCase
            self.getParticipatedBranchesUseCase = getParticipatedBranchesUseCase
            self.getOwnedBranchesUseCase = getOwnedBranchesUseCase
            self.commit = commit
        }

        private var connectBranchUseCase: ConnectBranchUseCaseProtocol
        private var getParticipatedBranchesUseCase: GetParticipatedBranchesUseCaseProtocol
        private var getOwnedBranchesUseCase: GetOwnedBranchesUseCase

        @Published var branches: [AmplifyBranch] = []
        var commit: AmplifyCommit

        @Published var selectedBranch: AmplifyBranch?

        @Published var hasError = false
        @Published var appError: Error?

        // MARK: Delete branch

        func connectBranch() {
            Task {
                do {
                    guard let selectedBranch else {return}
                    try await connectBranchUseCase.execute(commit: commit, branch: selectedBranch)

                } catch {
                    hasError = true
                    appError = error as? Error
                }
            }
        }

        func getAvailableBranchs(page: Int) async {
            do {
                let ownedbranches = try await getOwnedBranchesUseCase.execute(page: page)
                var participatedBranches:[AmplifyBranch] = []
                if let userID = AppRepoManager.shared.dataStoreRepo.amplifyUser?.id {
                    participatedBranches = try await getParticipatedBranchesUseCase.execute(userID:userID)
                }
                DispatchQueue.main.async {
                    self.branches = ownedbranches + participatedBranches
                }

                print("fetched branches: \(branches.count)")


            } catch {
                hasError = true
                appError = error as? Error
            }
        }
    }
}

struct BranchConnectView: View {
    @StateObject var viewModel: ViewModel

    @Environment(\.dismiss) var dismiss

    init(commit: AmplifyCommit, connectBranchUseCase: ConnectBranchUseCaseProtocol = ConnectBranchUseCase(), getParticipatedBranchesUseCase: GetParticipatedBranchesUseCaseProtocol = GetParticipatedBranchesUseCase(), getOwnedBranchesUseCase: GetOwnedBranchesUseCase = GetOwnedBranchesUseCase()) {
        _viewModel = StateObject(wrappedValue: ViewModel(commit: commit, connectBranchUseCase: connectBranchUseCase, getParticipatedBranchesUseCase: getParticipatedBranchesUseCase, getOwnedBranchesUseCase: getOwnedBranchesUseCase))
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
                ForEach(viewModel.branches, id: \.id) { branch in

                    BranchCardView(branch: branch)
                        .onTapGesture {
                            viewModel.selectedBranch = branch
                            viewModel.connectBranch()
                            dismiss()
                        }
                }
            }
        }
        .padding(.horizontal, .ewPaddingHorizontalDefault)
        .padding(.vertical, .ewPaddingVerticalDefault)
        .task {
            await viewModel.getAvailableBranchs(page: 0)
        }
    }
}

struct BranchConnectView_Previews: PreviewProvider {
    static var commit: AmplifyCommit = .init(commitType: .moment, order: 0)
    static var previews: some View {
        BranchConnectView(commit: commit)
    }
}
