//
//  GetParticipatedBranchUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/23.
//

import Amplify
import Foundation

class GetParticipatedBranchesUseCase: GetParticipatedBranchesUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(userID: String) async throws -> [AmplifyBranch] {
        let participates = try await manager.dataStoreRepo.queryParticipants(userID: userID)

        let branchIDs: [String] = participates.map { $0.toBranch.id }

        return try await manager.dataStoreRepo.queryBranches(where: branchIDs.contains(AmplifyBranch.keys.id.rawValue) as? QueryPredicate, sort: nil, paginate: nil)
    }
}
