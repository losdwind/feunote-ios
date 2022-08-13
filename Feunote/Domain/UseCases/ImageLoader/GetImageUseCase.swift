//
//  GetImageUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/9.
//

import Amplify
import Foundation

protocol GetImageUseCaseProtocol {
    func execute(key: String) async throws -> Data
}

class GetImageUseCase: GetImageUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(key: String) async throws -> Data {
        return try await manager.storageRepo.downloadImage(key: key)
    }
}
