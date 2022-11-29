//
//  GetSourceUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/11/28.
//

import Foundation
class GetSourcesUseCase: GetSourcesUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(creatorID: String) async throws -> [AmplifySource] {
        return try await manager.dataStoreRepo.querySources(creatorID: creatorID)
    }
}
