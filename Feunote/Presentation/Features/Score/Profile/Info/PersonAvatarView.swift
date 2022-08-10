//
//  AvatarView.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/8.
//

import Amplify
import Combine
import Foundation
import Kingfisher
import SwiftUI
struct PersonAvatarView: View {
    @StateObject private var viewModel: ViewModel
    var style: AvatarStyleEnum

    init(imageKey: String?, style: AvatarStyleEnum = .medium) {
        _viewModel = StateObject(wrappedValue: ViewModel(imageKey: imageKey, getImageUseCase: GetImageUseCase()))
        self.style = style
    }

    var body: some View {
        EWAvatarImage(avatar: viewModel.getImage() ?? UIImage(systemName: "exclamationmark.icloud")!, style: style)
    }

    struct PersonAvatarView_Previews: PreviewProvider {
        static var previews: some View {
            PersonAvatarView(imageKey: "", style: .medium)
        }
    }
}

extension PersonAvatarView {
    class ViewModel: ObservableObject {
        @Published var imageKey: String?

        private var subscribers = Set<AnyCancellable>()
        private var getImageUseCase: GetImageUseCaseProtocol
        @Published var hasError = false
        @Published var error: AmplifyError?

        init(imageKey: String?, getImageUseCase: GetImageUseCaseProtocol,
             manager _: AppRepositoryManagerProtocol = AppRepoManager.shared)
        {
            self.imageKey = imageKey
            self.getImageUseCase = getImageUseCase
        }

        func getImage() -> UIImage? {
            guard let ImageKey = imageKey else {
                return nil
            }
            var image: UIImage?

            let ops = getImageUseCase.execute(key: ImageKey)

            ops.resultPublisher.sink {
                if case let .failure(storageError) = $0 {
                    self.error = storageError
                }
            }
        receiveValue: { data in
                image = UIImage(data: data)
            }
            .store(in: &subscribers)
            return image
        }
    }
}
