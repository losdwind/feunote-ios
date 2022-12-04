//
//  ImageUploader.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/8.
//

import Amplify
import Foundation
import UIKit

class SaveProfileAvatarUseCase: SaveProfileImageUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(image: UIImage) async throws -> String {
        guard let username = manager.authRepo.authUser?.username, let userID = manager.authRepo.authUser?.userId else { throw AppError.invalidLoginStatus}
        let key = "User/Avatar/\(manager.identityId)"
        let pngData = image.pngFlattened(isOpaque: true) ?? Data()
        let options = StorageUploadDataRequest.Options(accessLevel: .protected)
        return try await manager.storageRepo.uploadImage(key: key, data: pngData,options:options)
    }
}
