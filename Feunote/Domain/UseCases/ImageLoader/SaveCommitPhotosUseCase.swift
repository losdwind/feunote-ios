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
    func execute(photos: [UIImage], commitID: String) -> [StorageUploadDataOperation]
}

class SaveCommitPhotosUseCase: SaveCommitPhotosUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(photos: [UIImage], commitID: String) -> [StorageUploadDataOperation] {
        guard let user = manager.dataStoreRepo.amplifyUser else { return [] }
        var storageOperation: [StorageUploadDataOperation] = []
        for photo in photos {
            let key = "\(commitID)/\(UUID().uuidString)"
            if let pngData = photo.pngFlattened(isOpaque: true) {
                storageOperation.append(manager.storageRepo.uploadImage(key: key, data: pngData, accessLevel: .private))
            }
        }
        return storageOperation
    }
}
