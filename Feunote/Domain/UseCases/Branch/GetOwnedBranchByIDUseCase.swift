//
//  GetOwnBranchByIDUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import Amplify
import Foundation
class GetOwnedBranchByIDUseCase: GetBranchByIDUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(branchID: String) async throws -> AmplifyBranch {
        let branch = try await manager.dataStoreRepo.queryBranches(where: AmplifyBranch.keys.id == branchID, sort: nil, paginate: nil).first
        if branch != nil {
            return branch!
        } else {
            throw AppError.failedToRead
        }
    }
}
