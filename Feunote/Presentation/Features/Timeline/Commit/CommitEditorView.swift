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

    init(commit: AmplifyCommit, saveCommitPhotosUseCase: SaveCommitPhotosUseCaseProtocol = SaveCommitPhotosUseCase(), saveCommitUseCase: SaveCommitUseCaseProtocol = SaveCommitUseCase(), savePersonAvatarUseCase: SavePersonAvatarUseCaseProtocol = SavePersonAvatarUseCase()) {
        _viewModel = StateObject(wrappedValue: ViewModel(commit: commit, saveCommitPhotosUseCase: saveCommitPhotosUseCase, saveCommitUseCase: saveCommitUseCase, savePersonAvatarUseCase: savePersonAvatarUseCase))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
            switch viewModel.commit.commitType {
            case .moment:
                CommitMomentEditor(moment: $viewModel.commit)
            case .todo:
                CommitTodoEditor(todo: $viewModel.commit)
            case .person:
                CommitPersonEditor(person: $viewModel.commit, avatar: $viewModel.avatar)
            }

            HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall) {
                if viewModel.commit.photoKeys != nil, viewModel.images != [] {
                    CommitPhotosView(photoKeys: viewModel.commit.photoKeys!)
                }
                EWPhotosAdd(images: $viewModel.images)
            }
            EWButton(text: "Save", image: nil, style: .primarySmall, action: {
                playSound(sound: "sound-ding", type: "mp3")
                dismiss()
                viewModel.saveCommit()
            })
            .frame(maxWidth: .infinity, alignment: .trailing)
        }

        .padding()
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text("Message"), message: Text(viewModel.error?.localizedDescription ?? "Save Error Occurred"), dismissButton: .destructive(Text("Ok")))
        }
    }
}

struct CommitEditor_Previews: PreviewProvider {
    static var previews: some View {
        CommitEditorView(commit: AmplifyCommit(commitType: .moment))
    }
}

extension CommitEditorView {
    @MainActor
    class ViewModel: ObservableObject {
        internal init(commit: AmplifyCommit, saveCommitPhotosUseCase: SaveCommitPhotosUseCaseProtocol, saveCommitUseCase: SaveCommitUseCaseProtocol, savePersonAvatarUseCase: SavePersonAvatarUseCaseProtocol) {
            self.saveCommitPhotosUseCase = saveCommitPhotosUseCase
            self.savePersonAvatarUseCase = savePersonAvatarUseCase
            self.saveCommitUseCase = saveCommitUseCase
            self.commit = commit
        }

        @Published var images: [UIImage] = []
        @Published var avatar: UIImage?
        @Published var commit: AmplifyCommit
        @Published var hasError: Bool = false
        @Published var error: Error?

        private var saveCommitPhotosUseCase: SaveCommitPhotosUseCaseProtocol
        private var savePersonAvatarUseCase: SavePersonAvatarUseCaseProtocol
        private var saveCommitUseCase: SaveCommitUseCaseProtocol
        private var subscribers = Set<AnyCancellable>()

        func savePhotos() async throws -> [String] {
            guard self.images != [] else { return [] }
            let images = self.images
            let commitID = commit.id
            let keys = try await saveCommitPhotosUseCase.execute(photos: images, commitID: commitID)
            return keys
        }

        func saveAvatar() async throws -> String {
            guard let avatar = avatar else { return "" }
            let commitID = commit.id
            let avatarKey = try await savePersonAvatarUseCase.execute(avatarImage: avatar, commitID: commitID)
            return avatarKey
        }

        func saveCommit() {
            Task {
                do {
                    let keys = try await self.savePhotos()
                    let avatarKey = try await self.saveAvatar()
                    var commit = self.commit
                    commit.photoKeys = keys == [] ? nil : keys
                    commit.personAvatarKey = avatarKey == "" ? nil : avatarKey
                    try await self.saveCommitUseCase.execute(commit: commit)
                    print("success to uploaded photos \(commit.photoKeys)")
                    print("success to uploaded avatar \(commit.personAvatarKey)")
                    print("success to save commit \(commit.commitType.rawValue.description)")
                    self.commit = AmplifyCommit(commitType: commit.commitType)
                    self.avatar = nil
                    self.images = []
                } catch {
                    hasError = true
                    self.error = error as? Error
                }
            }
        }
    }
}
