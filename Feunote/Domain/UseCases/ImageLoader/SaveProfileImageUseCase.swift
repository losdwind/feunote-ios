//
//  ImageUploader.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/8.
//

import Amplify
import Foundation
import Kingfisher
import UIKit
class SaveProfileImageUseCase: SaveImageUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(image: UIImage, key: String) -> StorageUploadDataOperation {
        let pngData = image.pngFlattened(isOpaque: true) ?? Data()
        return manager.storageRepo.uploadImage(key: key, data: pngData, accessLevel: .protected)
    }
}
