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
    func execute(avatarImage: UIImage, commitID: String) async throws -> String
}

class SavePersonAvatarUseCase: SavePersonAvatarUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(avatarImage: UIImage, commitID: String) async throws -> String {
        let key = "Commit/Person/Avatar/\(commitID)/\(UUID().uuidString)"
        guard let pngData = avatarImage.pngFlattened(isOpaque: true) else {throw AppError.itemCannotBeFlattened}
        let options = StorageUploadDataRequest.Options(accessLevel: .private)
        return try await manager.storageRepo.uploadImage(key: key, data: pngData, options: options)
    }
}
