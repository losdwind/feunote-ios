//
//  GetCommitsByBranchID.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/10.
//

import Amplify
import Foundation

protocol GetCommitsByBranchIDUseCaseProtocol {
    func execute(branchID: String, page: Int) async throws -> [AmplifyCommit]
}

class GetCommitsByBranchIDUseCase: GetCommitsByBranchIDUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(branchID: String, page: Int) async throws -> [AmplifyCommit] {
        let predicateInput: QueryPredicate? = AmplifyCommit.keys.toBranch == branchID
        let sortInput = QuerySortInput.descending(AmplifyCommit.keys.createdAt)
        let paginationInput = QueryPaginationInput.page(UInt(page), limit: 20)

        return try await manager.dataStoreRepo.queryCommits(where: predicateInput, sort: sortInput, paginate: paginationInput)
    }
}
