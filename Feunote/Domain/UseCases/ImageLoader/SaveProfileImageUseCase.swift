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

    func execute(image: UIImage) async throws -> String {
        guard let user = manager.dataStoreRepo.amplifyUser else { throw AppError.invalidLoginStatus}
        let key = String("\(user.username)")
        let pngData = image.pngFlattened(isOpaque: true) ?? Data()
        return try await manager.storageRepo.uploadImage(key: key, data: pngData)
    }
}
