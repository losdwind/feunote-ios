//
//  AvatarView.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/8.
//

import Foundation
import SwiftUI
import Kingfisher
struct ProfileImageView: View {
    @StateObject private var viewModel: ViewModel

    var body: some View {
        EWAvatarImage()
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView()
    }
}




extension ProfileImageView {

    class ViewModel: ObservableObject {

        @Published var profileImageKey: String?

        private var subscribers = Set<AnyCancellable>()

        init(profileImageKey: String,
             manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
            self.profileImageKey = profileImageKey
            manager.dataStoreRepo.eventsPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in },
                      receiveValue: onReceive(event:)
                )
                .store(in: &subscribers)
        }

        private func onReceive(event: DataStoreServiceEvent) {
            switch event {
                case .userSynced(let user):
                    profileImageKey = user.avatarKey
                case .userUpdated(let user):
                    profileImageKey = user.avatarKey
                default:
                    break
            }
        }

        func profileImageSource() -> Data {
            return GetKFImageSourceUseCase().execute(key: self.profileImageKey)
        }
    }
}
