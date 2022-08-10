//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import SwiftUI
import Amplify
import Combine
import Kingfisher

struct ProfileUpdateAvatarView: View {

    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: ViewModel = ViewModel(saveProfileImageUseCase: SaveProfileImageUseCase())
    @State private var isShowingImagePicker:Bool = false
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
                .accentColor(colorScheme == .light ? .ewPrimaryBase: .ewPrimary100)
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
        @Published private(set) var error: AmplifyError?

        private var subscribers = Set<AnyCancellable>()
        private var saveProfileImageUseCase:SaveProfileImageUseCaseProtocol


        func updateProfileImage() {

            guard let selectedImage = selectedImage else {
                return
            }


            let storageOperation = saveProfileImageUseCase.execute(image: selectedImage)


            storageOperation.progressPublisher.sink { progress in
                DispatchQueue.main.async {
                    self.progress = progress
                }
                print(progress as Progress)
            }
            .store(in: &subscribers)

            storageOperation.resultPublisher.sink {
                if case let .failure(storageError) = $0 {
                    DispatchQueue.main.async {
                        self.error = storageError
                        self.hasError = true
                    }
                    Amplify.log.error(
                        "Error uploading selected image - \(storageError.localizedDescription)"
                    )
                    return
                }


                // This is to remove the old image from local cache. The reason is that the new image is
                // using the same image key, `KFImage` displays the old image even new image is uploaded to S3
                let key = storageOperation.request.key
                ImageCache.default.removeImage(forKey: key)

                DispatchQueue.main.async {
                    self.progress = nil
                }

            }
        receiveValue: { _ in }
                .store(in: &subscribers)
        }
    }
}
