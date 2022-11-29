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

//        if viewModel.avatar != nil {
//            EWAvatarImage(avatar: viewModel.avatar!)
//        } else if viewModel.imageKey != nil {
//            ProgressView()
//                .task{ await viewModel.getImage()}
//        } else {
//            EWAvatarImage(avatar:UIImage(systemName: "person.badge.plus")! )
//
//        }

        if let imageKey =  viewModel.imageKey{
            KFAvatarImage(key: imageKey)
        } else {
            EWAvatarImage(avatar:UIImage(systemName: "person.badge.plus")! )
        }


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

        func getImage() async {

                do {
                    guard let imageKey = imageKey else { throw AppError.itemDoNotExist}
                    let data = try await getImageUseCase.execute(key: imageKey)
                    DispatchQueue.main.async {
                        self.avatar = UIImage(data: data)
                    }

                } catch {
                    DispatchQueue.main.async {
                        self.hasError = true
                        self.error = error
                    }

                }

        }
    }
}
