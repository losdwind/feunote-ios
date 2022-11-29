//
//  MomentView.swift
//  Beliski-Firebase
//
//  Created by Wind Losd on 2021/9/17.
//

import PartialSheet
import SwiftUI

extension CommitListView {
    @MainActor
    class ViewModel: ObservableObject {
        internal init(deleteCommitUseCase: DeleteCommitUseCaseProtocol, saveCommitUseCase: SaveCommitUseCaseProtocol) {
            self.deleteCommitUseCase = deleteCommitUseCase
            self.saveCommitUseCase = saveCommitUseCase
        }

        @Published var hasError = false
        @Published var appError: Error?

        private var deleteCommitUseCase: DeleteCommitUseCaseProtocol
        private var saveCommitUseCase: SaveCommitUseCaseProtocol

        func deleteCommit(commitID: String) {
            Task {
                do {
                    try await deleteCommitUseCase.execute(commitID: commitID)
                } catch {
                    hasError = true
                    appError = error as? Error
                }
            }
        }

        func saveCommit(commit: AmplifyCommit) {
            Task {
                do {
                    try await saveCommitUseCase.execute(commit: commit)
                    playSound(sound: "sound-ding", type: "mp3")
                    print("success to save commit \(commit.commitType.rawValue.description)")

                } catch {
                    hasError = true
                    appError = error as? Error
                }
            }
        }

        func toggleTodoCompletion(todo: AmplifyCommit) {
            Task {
                var newTodo = todo
                newTodo.todoCompletion?.toggle()
                print("before save Todo with completion status: \(newTodo.todoCompletion)")
                await self.saveCommit(commit: newTodo)
            }
        }
    }
}

struct CommitListView: View {
    @StateObject var viewModel: ViewModel
    @State var isUpdatingCommit = false
    @State var isConnectingToBranch = false
    @Binding var fetchedCommits:[AmplifyCommit]

    @Environment(\.colorScheme) var colorScheme

    init(fetchedCommits: Binding<[AmplifyCommit]>, deleteCommitUseCase: DeleteCommitUseCaseProtocol = DeleteCommitUseCase(), saveCommitUseCase: SaveCommitUseCaseProtocol = SaveCommitUseCase()) {
        self._fetchedCommits = fetchedCommits
        _viewModel = StateObject(wrappedValue: ViewModel( deleteCommitUseCase: deleteCommitUseCase, saveCommitUseCase: saveCommitUseCase))
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .center, spacing: .ewPaddingVerticalLarge) {
                ForEach($fetchedCommits, id: \.id) { $commit in

                    Group {
                        switch commit.commitType {
                        case .moment:
                            CommitMomentView(moment: commit)
                        case .todo:
                            CommitTodoView(todo: commit, action: {
                                viewModel.toggleTodoCompletion(todo: commit)
                            })
                        case .person:
                            CommitPersonView(person: commit)
                        }
                    }
                    .contextMenu {
                        // Delete
                        Button {
                            viewModel.deleteCommit(commitID: commit.id)
                            fetchedCommits.removeAll(where:{ $0.id == commit.id})
                        } label: {
                            Label(
                                title: { Text("Delete") },
                                icon: { Image(systemName: "trash.circle") }
                            )
                        }

                        // Edit
                        Button {
                            isUpdatingCommit = true
                        } label: {
                            Label(
                                title: { Text("Edit") },
                                icon: { Image(systemName: "pencil.circle") }
                            )
                        }

                        // Link
                        Button {
                            isConnectingToBranch = true
                        } label: {
                            Label(
                                title: { Text("Link") },
                                icon: { Image(systemName: "link.circle") }
                            )
                        }
                    }
                    .partialSheet(isPresented: $isUpdatingCommit) {
                        CommitEditorView(commit: commit)
                    }
                    .fullScreenCover(isPresented: $isConnectingToBranch) {
                        BranchConnectView(commit: commit)
                    }

                }
            }
        }
    }
}

struct CommitListView_Previews: PreviewProvider {
    @State static var fetchedCommits:[AmplifyCommit] = []
    static var previews: some View {
        CommitListView(fetchedCommits: $fetchedCommits)
    }
}
