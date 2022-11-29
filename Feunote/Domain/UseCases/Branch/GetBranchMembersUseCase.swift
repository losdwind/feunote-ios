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
        guard let branch = try await manager.dataStoreRepo.queryBranch(byID: branchID)
        else {return []}

         let owner = try await manager.dataStoreRepo.queryUsers(where: (AmplifyUser.keys.username == branch.owner), sort: nil, paginate: nil)

        let members = try await manager.dataStoreRepo.queryMembers(branchID: branchID)
        return owner + members
    }
}
