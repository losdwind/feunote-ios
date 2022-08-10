//
//  GetBranchMembers.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/10.
//

import Amplify
import Foundation

protocol GetBranchMembersUseCaseProtocol {
    func execute(branchID: String) async throws -> [AmplifyUser]
}

class GetBranchMembersUseCase: GetBranchMembersUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(branchID: String) async throws -> [AmplifyUser] {
        return try await manager.dataStoreRepo.queryMembers(branchID: branchID)
    }
}
