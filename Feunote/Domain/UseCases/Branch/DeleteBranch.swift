//
//  DeleteBranch.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

class DeleteBranchUseCase: DeleteBranchUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(branchID: String) async throws {
        try await manager.dataStoreRepo.deleteBranch(branchID)
    }
}
