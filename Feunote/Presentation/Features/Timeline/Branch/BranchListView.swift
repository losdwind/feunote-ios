//
//  BranchCardListView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/31.
//

import Amplify
import SwiftUI

extension BranchListView {
    class ViewModel: ObservableObject {
        internal init(branches:[AmplifyBranch], deleteBranchUseCase: DeleteBranchUseCaseProtocol) {
            self.deleteBranchUseCase = deleteBranchUseCase
            self.branches = branches
        }

        private var deleteBranchUseCase: DeleteBranchUseCaseProtocol

        @Published var branches: [AmplifyBranch] = []

        @Published var hasError = false
        @Published var appError: AppError?

        // MARK: Delete branch

        func deleteBranch(branchID: String) {
            Task {
                do {
                    try await deleteBranchUseCase.execute(branchID: branchID)

                } catch {
                    hasError = true
                    appError = error as? AppError
                }
            }
        }
    }
}

struct BranchListView: View {
    @StateObject var viewModel: ViewModel

    @State var isUpdatingBranch = false
    @State var isShowingLinkedItemView = false
    @State var isShowingConnectView: Bool = false

    init(branches:[AmplifyBranch], deleteBranchUseCase: DeleteBranchUseCaseProtocol = DeleteBranchUseCase()) {
        self._viewModel = StateObject(wrappedValue: ViewModel(branches: branches, deleteBranchUseCase: deleteBranchUseCase))
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
                ForEach(viewModel.branches, id: \.id) { branch in

                    NavigationLink {
                        BranchLinkedItemsView(branch: branch)
                    } label: {

                        BranchView(branch: branch)
                    }

                    .contextMenu {
                        // Delete
                        Button {
                            viewModel.deleteBranch(branchID: branch.id)

                        } label: {
                            Label(title: {
                                Text("Delete")
                            }, icon: {
                                Image(systemName: "trash.circle")
                            })
                        }
                        .disabled(branch.owner != AppRepoManager.shared.dataStoreRepo.amplifyUser?.id)

                        // Edit
                        Button {
                            isUpdatingBranch = true
                        } label: { Label(
                            title: { Text("Edit") },
                            icon: { Image(systemName: "pencil.circle") }) }
                            .disabled(branch.owner != AppRepoManager.shared.dataStoreRepo.amplifyUser?.id)
                    }
                    .onTapGesture {
                        isShowingLinkedItemView.toggle()
                    } //: onTapGesture

                    .sheet(isPresented: $isUpdatingBranch) {
                        BranchEditorView(branch: branch)
                    }
                    .sheet(isPresented: $isShowingConnectView) {
                        EmptyView()
                    }
                }
            }
        }

    }
}

struct BranchListView_Previews: PreviewProvider {
    static var previews: some View {
        BranchListView(branches: [])
    }
}
