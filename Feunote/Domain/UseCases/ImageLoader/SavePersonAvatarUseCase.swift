//
//  SavePersonAvatarUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/9.
//

import Amplify
import Foundation
import UIKit
protocol SavePersonAvatarUseCaseProtocol {
    func execute(avatarImage: UIImage, commitID: String) -> StorageUploadDataOperation
}

class SavePersonAvatarUseCase: SavePersonAvatarUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(avatarImage: UIImage, commitID: String) -> StorageUploadDataOperation {
        let pngData = avatarImage.pngFlattened(isOpaque: true)
        let key = "\(commitID)/\(UUID().uuidString)"
        return manager.storageRepo.uploadImage(key: key, data: pngData ?? Data(), accessLevel: .private)
    }
}
