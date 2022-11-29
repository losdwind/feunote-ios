//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import Amplify
import Combine
import Kingfisher
import SwiftUI

struct ProfileUpdateAvatarView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: ViewModel = .init(saveProfileImageUseCase: SaveProfileAvatarUseCase())
    @State private var isShowingImagePicker: Bool = false
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            if let progress = viewModel.progress {
                ProgressView(value: CGFloat(progress.completedUnitCount),
                             total: CGFloat(progress.totalUnitCount))
            }
            if let selectedImage = viewModel.selectedImage {
                EWAvatarImage(avatar: selectedImage)
            }
        }

        .transition(.asymmetric(insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)))
        .sheet(isPresented: $isShowingImagePicker, onDismiss: {
            viewModel.updateProfileImage()
        }) {
            ImagePicker(image: $viewModel.selectedImage)
                .preferredColorScheme(colorScheme)
                .accentColor(colorScheme == .light ? .ewPrimaryBase : .ewPrimary100)
        }
    }
}

struct ConfirmProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUpdateAvatarView()
    }
}

extension ProfileUpdateAvatarView {
    class ViewModel: ObservableObject {
        internal init(saveProfileImageUseCase: SaveProfileImageUseCaseProtocol) {
            self.saveProfileImageUseCase = saveProfileImageUseCase
        }

        @Published var selectedImage: UIImage?
        @Published private(set) var progress: Progress?
        @Published private(set) var hasError: Bool = false
        @Published private(set) var error: Error?

        private var subscribers = Set<AnyCancellable>()
        private var saveProfileImageUseCase: SaveProfileImageUseCaseProtocol

        func updateProfileImage() {
            Task {
                do {
                    guard let selectedImage = selectedImage else { return }
                    try await saveProfileImageUseCase.execute(image: selectedImage)
                } catch {
                    self.hasError = true
                    self.error = error
                }
            }
        }
    }
}
