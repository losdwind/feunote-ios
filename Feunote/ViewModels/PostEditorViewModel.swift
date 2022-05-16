//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import SwiftUI
import Amplify
import Combine

extension PostEditorView {

    class ViewModel: ObservableObject {
        @Published var selectedImage: UIImage?
        @Published var progress: Progress?
        @Published var hasError: Bool = false
        @Published var error: AmplifyError?

        private var subscribers = Set<AnyCancellable>()

        var dataStoreService: DataStoreServiceProtocol
        var storageService: StorageServiceProtocol

        init(image: UIImage,
             manager: AppServiceManagerProtocol = AppServiceManager.shared) {
            self.selectedImage = image
            self.dataStoreService = manager.dataStoreService
            self.storageService = manager.storageService
        }

        var viewDismissalPublisher = PassthroughSubject<Bool, Never>()
        private var shouldDismissView = false {
            didSet {
                viewDismissalPublisher.send(shouldDismissView)
            }
        }

        func createNewPost(postBody: String) {
            guard let user = dataStoreService.user else { return }

            var newPost = Post(postBody: postBody,
                               pictureKey: "",
                               createdAt: .now(),
                               postedBy: user)
            let pictureKey = "\(user.username)Image\(newPost.id)"
            newPost.pictureKey = pictureKey

            guard let pngData = selectedImage?.pngFlattened(isOpaque: true) else {
                return
            }

            let storageOperation = storageService.uploadImage(key: "\(newPost.pictureKey)",pngData)
            
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
                self.dataStoreService.savePost(newPost) {
                    switch $0 {
                    case .success:
                        DispatchQueue.main.async {
                            self.progress = nil
                            self.shouldDismissView = true
                        }
                    case .failure(let dataStoreError):
                        DispatchQueue.main.async {
                            self.error = dataStoreError
                            self.hasError = true
                        }
                    }
                }
            }
            receiveValue: { _ in }
            .store(in: &subscribers)
        }
    }

    enum CurrentPage {
        case imagePicker
        case postEditorView
    }
}
