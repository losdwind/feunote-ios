//
//  GetOpenBranchByID.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/23.
//

import Amplify
import Foundation
class GetOpenBranchByIDUseCase: GetBranchByIDUseCaseProtocol {


    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(branchID: String) async throws -> AmplifyBranch? {
        return try await manager.dataStoreRepo.queryOpenBranchByID(branchID: branchID)
    }
}
