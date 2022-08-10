//
//  SaveBranch.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

class SaveBranchUseCase: SaveBranchUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(branch: AmplifyBranch) async throws {
        try await manager.dataStoreRepo.saveBranch(branch)
    }
}
