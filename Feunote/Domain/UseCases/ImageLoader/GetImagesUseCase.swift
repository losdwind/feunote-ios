//
//  GetImagesUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/9.
//

import Amplify
import Foundation

protocol GetImagesUseCaseProtocol {
    func execute(keys: [String]) async throws -> [Data]
}

class GetImagesUseCase: GetImagesUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(keys: [String]) async throws -> [Data] {
        return try await withThrowingTaskGroup(of: Data.self) { group in
            var resources = [Data]()
            for key in keys {
                group.addTask {
                    return try await self.manager.storageRepo.downloadImage(key: key)
                }
            }
            for try await resource in group {
                resources.append(resource)
            }

            return resources

        }
    }
}
