//
//  SaveImageUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/9.
//

import Amplify
import Foundation
import UIKit

protocol SaveCommitPhotosUseCaseProtocol {
    func execute(photos: [UIImage], commitID: String) async throws -> [String]
}

class SaveCommitPhotosUseCase: SaveCommitPhotosUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(photos: [UIImage], commitID: String) async throws ->  [String] {
        guard let user = manager.dataStoreRepo.amplifyUser else { return [] }
        return try await withThrowingTaskGroup(of: String.self, body: { group in
            var keys: [String] = []
            for photo in photos {
                group.addTask {
                    let key = "Commit/Photos/\(commitID)/\(UUID().uuidString)"
                    guard let pngData = photo.pngFlattened(isOpaque: true) else {throw AppError.itemCannotBeFlattened}
                    return try await self.manager.storageRepo.uploadImage(key: key, data: pngData)
                }

            }
            for try await key in group {
                keys.append(key)
            }
            return keys
        })
    }
}
