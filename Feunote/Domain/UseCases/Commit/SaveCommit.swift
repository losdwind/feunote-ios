//
//  SaveCommit.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

class SaveCommitUseCase: SaveCommitUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(commit: AmplifyCommit) async throws {
        try await manager.dataStoreRepo.saveCommit(commit)
    }
}
