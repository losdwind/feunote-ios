//
//  AvatarImageView.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/9.
//

import Amplify
import Combine
import Foundation
import Kingfisher
import SwiftUI
struct CommitPhotosView: View {
    @StateObject private var viewModel: ViewModel

    init(photoKeys: [String?]) {
        _viewModel = StateObject(wrappedValue: ViewModel(photoKeys: photoKeys, getPhotosUseCase: GetImagesUseCase()))
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.getPhotos(), id: \.self) {
                    image in
                    if image != nil {
                        Image(uiImage: image!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                    } else {
                        Image(systemName: "exclamationmark.icloud")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                            .frame(width: 50, height: 50)
                    }
                }
            }
        }
    }
}

struct CommitPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        CommitPhotosView(photoKeys: [])
    }
}

extension CommitPhotosView {
    class ViewModel: ObservableObject {
        @Published var photoKeys: [String?]

        private var subscribers = Set<AnyCancellable>()
        private var getPhotosUseCase: GetImagesUseCaseProtocol
        @Published var hasError = false
        @Published var error: AmplifyError?

        init(photoKeys: [String?], getPhotosUseCase: GetImagesUseCaseProtocol,
             manager _: AppRepositoryManagerProtocol = AppRepoManager.shared)
        {
            self.photoKeys = photoKeys
            self.getPhotosUseCase = getPhotosUseCase
        }

        func getPhotos() -> [UIImage?] {
            let operations = getPhotosUseCase.execute(keys: photoKeys.compactMap { $0 })
            var photos: [UIImage?] = []
            for ops in operations {
                ops.resultPublisher.sink {
                    if case let .failure(storageError) = $0 {
                        self.error = storageError
                    }
                }
            receiveValue: { data in
                    photos.append(UIImage(data: data))
                }
                .store(in: &subscribers)
            }
            return photos
        }
    }
}
