//
//  GetAllBranches.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/14.
//

import Foundation

import Amplify

class GetOwnedBranchesUseCase: GetBranchesUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(page: Int) async throws -> [AmplifyBranch] {
        let predicateInput: QueryPredicate? = nil
        let sortInput = QuerySortInput.descending(AmplifyBranch.keys.updatedAt)
        let paginationInput = QueryPaginationInput.page(UInt(page), limit: 100)
        return try await manager.dataStoreRepo.queryBranches(where: predicateInput, sort: sortInput, paginate: paginationInput)
    }
}
