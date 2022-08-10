//
//  GetBetterLifeIndexUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/3.
//

import Foundation

class GetBetterLifeIndexUseCase: GetBetterLifeIndexUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(location: String) async -> BetterLifeIndexData? {
        return try await manager.remoteApiRepo.queryOECDInfo(location: location)
    }
}
