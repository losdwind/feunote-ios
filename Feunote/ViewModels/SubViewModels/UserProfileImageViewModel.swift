//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import Combine
import Foundation
import Kingfisher

extension UserProfileImageView {

    class ViewModel: ObservableObject {

        @Published var profileImageKey: String

        var dataStoreService: DataStoreServiceProtocol

        private var subscribers = Set<AnyCancellable>()

        init(profileImageKey: String,
             manager: AppServiceManagerProtocol = AppServiceManager.shared) {
            self.profileImageKey = profileImageKey
            self.dataStoreService = manager.dataStoreService
            manager.dataStoreService.eventsPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in },
                      receiveValue: onReceive(event:)
                )
                .store(in: &subscribers)
        }

        private func onReceive(event: DataStoreServiceEvent) {
            switch event {
            case .userSynced(let user):
                profileImageKey = user.profilePic
            case .userUpdated(let user):
                profileImageKey = user.profilePic
            default:
                break
            }
        }

        func profileImageSource() -> Source {
            return Source.provider(FeunoteImageProvider(key: profileImageKey))
        }
    }
}
