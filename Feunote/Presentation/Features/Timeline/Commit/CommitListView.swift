//
//  MomentView.swift
//  Beliski-Firebase
//
//  Created by Wind Losd on 2021/9/17.
//

import PartialSheet
import SwiftUI

extension CommitListView {
    class ViewModel: ObservableObject {
        internal init(fetchedCommits: [AmplifyCommit], deleteCommitUseCase: DeleteCommitUseCaseProtocol, saveCommitUseCase: SaveCommitUseCaseProtocol) {
            self.fetchedCommits = fetchedCommits
            self.deleteCommitUseCase = deleteCommitUseCase
            self.saveCommitUseCase = saveCommitUseCase
        }

        @Published var fetchedCommits: [AmplifyCommit]

        @Published var hasError = false
        @Published var appError: AppError?

        private var deleteCommitUseCase: DeleteCommitUseCaseProtocol
        private var saveCommitUseCase: SaveCommitUseCaseProtocol

        func deleteCommit(commitID: String) {
            Task {
                do {
                    try await deleteCommitUseCase.execute(commitID: commitID)
                } catch {
                    hasError = true
                    appError = error as? AppError
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
                    appError = error as? AppError
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

    @Environment(\.colorScheme) var colorScheme

    init(fetchedCommits: [AmplifyCommit], deleteCommitUseCase: DeleteCommitUseCaseProtocol = DeleteCommitUseCase(), saveCommitUseCase: SaveCommitUseCaseProtocol = SaveCommitUseCase()) {
        self._viewModel = StateObject(wrappedValue: ViewModel(fetchedCommits: fetchedCommits, deleteCommitUseCase: deleteCommitUseCase, saveCommitUseCase: saveCommitUseCase))
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .center, spacing: .ewPaddingVerticalLarge) {
                ForEach(viewModel.fetchedCommits, id: \.id) { commit in

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
                        } label: {
                            Label(
                                title: { Text("Delete") },
                                icon: { Image(systemName: "trash.circle") })
                        }

                        // Edit
                        Button {
                            isUpdatingCommit = true
                        } label: {
                            Label(
                                title: { Text("Edit") },
                                icon: { Image(systemName: "pencil.circle") })
                        }

                        // Link
                        Button {
                            isConnectingToBranch = true
                        } label: {
                            Label(
                                title: { Text("Link") },
                                icon: { Image(systemName: "link.circle") })
                        }
                    }
                    .partialSheet(isPresented: $isUpdatingCommit) {
                        CommitEditorView(commit: commit)
                    }
                    .fullScreenCover(isPresented: $isConnectingToBranch) {

                    }
                }
            }
        }
    }
}

struct CommitListView_Previews: PreviewProvider {
    static var previews: some View {
        CommitListView(fetchedCommits: [])
    }
}
