//
//  GetActionUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/11/28.
//

import Foundation
class GetActionByBranchIDUseCase: GetActionByBranchIDUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(branchID: String, actionType: ActionType) async throws -> AmplifyAction? {
        return try await manager.dataStoreRepo.queryAction(branchID: branchID, actionType: actionType)
    }
}
