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
        print("participated: \(branchIDs)")
        let checker = branchIDs.contains(AmplifyBranch.keys.id.rawValue) as? QueryPredicate
        print("predicated :\(checker)")
        var branches:[AmplifyBranch] = []
        for branchID in branchIDs {
            if let branch = try await manager.dataStoreRepo.queryBranch(byID: branchID){
                branches.append(branch)
            }
        }
        return branches
    }
}
