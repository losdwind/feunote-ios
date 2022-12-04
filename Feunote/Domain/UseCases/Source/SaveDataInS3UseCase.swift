//
//  SaveSourceInS3UseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/11/28.
//

import Amplify
import Foundation
import UIKit
protocol SaveDataUseCaseProtocol {
    func execute(data: Data, key:String) async throws -> String
}

class SaveDataUseCase: SaveDataUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(data: Data, key:String) async throws -> String {
        let options = StorageUploadDataRequest.Options(accessLevel: .private)
        return try await manager.storageRepo.uploadImage(key: key, data: data, options: options)
    }
}
