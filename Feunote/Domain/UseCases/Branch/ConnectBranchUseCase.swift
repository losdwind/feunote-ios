//
//  ConnectBranchUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/11/27.
//

import Foundation
import Amplify

class ConnectBranchUseCase: ConnectBranchUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(commit:AmplifyCommit, branch: AmplifyBranch) async throws {
        var latestCommit = try await manager.dataStoreRepo.queryCommit(byID: commit.id)
        let latestBranch = try await manager.dataStoreRepo.queryBranch(byID: branch.id)

        guard latestCommit != nil, latestBranch != nil else {throw AppError.invalidSubmit}

        latestCommit!.toBranch = latestBranch

        try await manager.dataStoreRepo.saveCommit(latestCommit!)
    }
}
