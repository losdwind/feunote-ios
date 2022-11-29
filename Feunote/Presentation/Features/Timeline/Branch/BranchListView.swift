//
//  BranchCardListView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/31.
//

import Amplify
import SwiftUI
import PartialSheet
extension BranchListView {
    @MainActor
    class ViewModel: ObservableObject {
        internal init(deleteBranchUseCase: DeleteBranchUseCaseProtocol) {
            self.deleteBranchUseCase = deleteBranchUseCase
        }

        private var deleteBranchUseCase: DeleteBranchUseCaseProtocol


        @Published var hasError = false
        @Published var appError: Error?

        // MARK: Delete branch

        func deleteBranch(branchID: String) {
            Task {
                do {
                    try await deleteBranchUseCase.execute(branchID: branchID)

                } catch {
                    hasError = true
                    appError = error as? Error
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
    @Binding var fetchedBranches:[AmplifyBranch]

    init(branches: Binding<[AmplifyBranch]>, deleteBranchUseCase: DeleteBranchUseCaseProtocol = DeleteBranchUseCase()) {
        self._fetchedBranches = branches
        _viewModel = StateObject(wrappedValue: ViewModel(deleteBranchUseCase: deleteBranchUseCase))
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
                ForEach($fetchedBranches, id: \.id) { $branch in

                    NavigationLink(destination: {
                        BranchLinkedItemsView(branch: branch)
                    }, label: {
                        BranchCardView(branch: branch)
                    })

                    .contextMenu {
                        // Delete
                        Button {
                            viewModel.deleteBranch(branchID: branch.id)
                            fetchedBranches.removeAll(where: {$0.id == branch.id})

                        } label: {
                            Label(title: {
                                Text("Delete")
                            }, icon: {
                                Image(systemName: "trash.circle")
                            })
                        }
                        .disabled(branch.owner != AppRepoManager.shared.dataStoreRepo.amplifyUser?.username)

                        // Edit
                        Button {
                            isUpdatingBranch = true
                        } label: { Label(
                            title: { Text("Edit") },
                            icon: { Image(systemName: "pencil.circle") }
                        ) }
                        .disabled(branch.owner != AppRepoManager.shared.dataStoreRepo.amplifyUser?.username)
                    }
                    .onTapGesture {
                        isShowingLinkedItemView.toggle()
                    } //: onTapGesture

                    .partialSheet(isPresented: $isUpdatingBranch) {
                        BranchEditorView(branch: branch)
                    }

                }
            }
        }
    }
}

struct BranchListView_Previews: PreviewProvider {
    @State static var branches:[AmplifyBranch] = []
    static var previews: some View {
        BranchListView(branches:$branches )
    }
}
