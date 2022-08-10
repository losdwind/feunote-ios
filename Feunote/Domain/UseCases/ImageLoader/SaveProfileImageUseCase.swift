//
//  ImageUploader.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/8.
//

import Amplify
import Foundation
import UIKit

class SaveProfileImageUseCase: SaveProfileImageUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(image: UIImage) -> StorageUploadDataOperation {
        guard let user = manager.dataStoreRepo.amplifyUser else { return StorageError.accessDenied("user login in status invalid", "please sign in again", nil) as! StorageUploadDataOperation }

        let key = String("\(user.username)")
        let pngData = image.pngFlattened(isOpaque: true) ?? Data()
        let ops = manager.storageRepo.uploadImage(key: key, data: pngData, accessLevel: .protected)
        return ops
    }
}
