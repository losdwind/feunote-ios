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
        EWAvatarImage(avatar: viewModel.avatar ?? UIImage(systemName: "person.badge.plus")!, style: style)
            .task{await viewModel.getImage()}
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

        @Published var avatar:UIImage?
        @Published var hasError = false
        @Published var error: Error?

        init(imageKey: String?, getImageUseCase: GetImageUseCaseProtocol,
             manager _: AppRepositoryManagerProtocol = AppRepoManager.shared)
        {
            self.imageKey = imageKey
            self.getImageUseCase = getImageUseCase
        }

        @MainActor func getImage() async {

                do {
                    guard let imageKey = imageKey else { throw AppError.itemDoNotExist}
                    let data = try await getImageUseCase.execute(key: imageKey)
                    self.avatar = UIImage(data: data)
                } catch {
                    self.hasError = true
                    self.error = error
                }

        }
    }
}
