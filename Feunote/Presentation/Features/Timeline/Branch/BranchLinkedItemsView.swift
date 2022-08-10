//
//  BranchLinkedItemsView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import SwiftUI

extension BranchLinkedItemsView {
    class ViewModel: ObservableObject {
        init(branch: AmplifyBranch, getCommitsByBranchIDUseCase: GetCommitsByBranchIDUseCaseProtocol) {
            self.branch = branch
            self.getCommitsByBranchIDUseCase = getCommitsByBranchIDUseCase
        }

        @Published var branch: AmplifyBranch
        @Published var fetchedAllCommitsFromBranch: [AmplifyCommit] = []
        @Published var hasError: Bool = false
        @Published var appError: AppError?

        private var getCommitsByBranchIDUseCase: GetCommitsByBranchIDUseCaseProtocol

        func getAllCommitsFromBranch() {
            Task {
                do {
                    self.fetchedAllCommitsFromBranch = try await getCommitsByBranchIDUseCase.execute(branchID: branch.id, page: 1)
                } catch {
                    hasError = true
                    appError = error as? AppError
                }
            }
        }
    }
}

struct BranchLinkedItemsView: View {
    @StateObject var viewModel: ViewModel
    @State var searchInput: String = ""
    @Environment(\.dismiss) var dismiss

    init(branch: AmplifyBranch, getCommitsByBranchIDUseCase: GetCommitsByBranchIDUseCaseProtocol = GetCommitsByBranchIDUseCase()) {
        _viewModel = StateObject(wrappedValue: ViewModel(branch: branch, getCommitsByBranchIDUseCase: getCommitsByBranchIDUseCase))
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            CommitListView(fetchedCommits: viewModel.fetchedAllCommitsFromBranch)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image("arrow-left-2")
                                .resizable().aspectRatio(contentMode: .fit)
                                .frame(width: 14, height: 14)
                                .foregroundColor(.ewBlack)
                        }
                    }

                    ToolbarItem(placement: .principal) {
                        Text("Branch Details")
                            .font(.ewHeadline)
                            .foregroundColor(.ewBlack)
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            SearchView(input: $searchInput)
                        } label: {
                            Image("search")
                        }
                    }
                })
                .onAppear(perform: {
                    viewModel.getAllCommitsFromBranch()
                })
                .padding()
        }
    }
}

struct BranchLinkedItemsView_Previews: PreviewProvider {
    static var previews: some View {
        BranchLinkedItemsView(branch: AmplifyBranch(privacyType: .private, title: "", description: ""))
    }
}
