//
//  CommitEditor.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/10.
//

import Amplify
import Combine
import SwiftUI

struct CommitEditorView: View {
    @StateObject private var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss

    init(commit: AmplifyCommit, saveCommitPhotosUseCase: SaveCommitPhotosUseCaseProtocol = SaveCommitPhotosUseCase(), saveCommitUseCase: SaveCommitUseCaseProtocol = SaveCommitUseCase()) {
        _viewModel = StateObject(wrappedValue: ViewModel(commit: commit, saveCommitPhotosUseCase: saveCommitPhotosUseCase, saveCommitUseCase: saveCommitUseCase))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
            switch viewModel.commit.commitType {
            case .moment:
                CommitMomentEditor(moment: $viewModel.commit, images: $viewModel.images)
            case .todo:
                CommitTodoEditor(todo: $viewModel.commit)
            case .person:
                CommitPersonEditor(person: $viewModel.commit, avatar: $viewModel.avatar)
            }
            EWButton(text: "Save", image: nil, style: .primarySmall) {
                viewModel.savePhotos()
                viewModel.saveCommit()
                dismiss()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text("Message"), message: Text(viewModel.error?.errorDescription ?? "default error"), dismissButton: .destructive(Text("Ok")))
        }
    }
}

struct CommitEditor_Previews: PreviewProvider {
    static var previews: some View {
        CommitEditorView(commit: AmplifyCommit(commitType: .moment))
    }
}

extension CommitEditorView {
    class ViewModel: ObservableObject {
        internal init(commit: AmplifyCommit, saveCommitPhotosUseCase: SaveCommitPhotosUseCaseProtocol, saveCommitUseCase: SaveCommitUseCaseProtocol) {
            self.saveCommitPhotosUseCase = saveCommitPhotosUseCase
            self.saveCommitUseCase = saveCommitUseCase
            self.commit = commit
        }

        @Published var images: [UIImage] = []
        @Published var avatar: UIImage?
        @Published var commit: AmplifyCommit
        @Published var hasError: Bool = false
        @Published var error: AppError?

        private var saveCommitPhotosUseCase: SaveCommitPhotosUseCaseProtocol
        private var saveCommitUseCase: SaveCommitUseCaseProtocol
        private var subscribers = Set<AnyCancellable>()

        func savePhotos() {
            guard images != [] else { return }
            var keys: [String] = []
            let operations = saveCommitPhotosUseCase.execute(photos: images, commitID: commit.id)
            for ops in operations {
                ops.resultPublisher.sink {
                    if case let .failure(storageError) = $0 {
                        DispatchQueue.main.async {
                            self.error = AppError.failedToLoadResource
                            self.hasError = true
                        }
                        Amplify.log.error("Error uploading selected image - \(storageError.localizedDescription)")
                        return
                    }
                    let key = ops.request.key
                    keys.append(key)
                }
            receiveValue: { _ in }
                .store(in: &subscribers)
            }
            commit.photoKeys = keys
        }

        func saveCommit() {
            Task {
                do {
                    try await saveCommitUseCase.execute(commit: commit)
                    playSound(sound: "sound-ding", type: "mp3")
                    print("success to save commit \(commit.commitType.rawValue.description)")

                } catch {
                    hasError = true
                    self.error = error as? AppError
                }
            }
        }
    }
}
