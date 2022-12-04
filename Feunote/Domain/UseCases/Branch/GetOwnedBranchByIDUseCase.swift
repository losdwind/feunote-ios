//
//  GetOwnBranchByIDUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import Amplify
import Foundation
class GetBranchByIDUseCase: GetBranchByIDUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(branchID: String) async throws -> AmplifyBranch? {
        let branch = try await manager.dataStoreRepo.queryBranch(byID: branchID)
        return branch

    }
}
