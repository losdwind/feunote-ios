//
//  GetImagesUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/9.
//

import Amplify
import Foundation

protocol GetImagesUseCaseProtocol {
    func execute(keys: [String]) -> [StorageDownloadDataOperation]
}

class GetImagesUseCase: GetImagesUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(keys: [String]) -> [StorageDownloadDataOperation] {
        var storageOperations: [StorageDownloadDataOperation] = []
        for key in keys {
            storageOperations.append(manager.storageRepo.downloadImage(key: key))
        }
        return storageOperations
    }
}
