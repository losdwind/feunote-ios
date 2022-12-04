//
//  GetOwnedOpenBranchesUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/12/3.
//

import Foundation

import Amplify

class GetOwnedOpenBranchesUseCase: GetBranchesUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(page: Int) async throws -> [AmplifyBranch] {
        guard let username = manager.dataStoreRepo.amplifyUser?.username else {return []}
        let predicateInput: QueryPredicate? = AmplifyBranch.keys.owner == username && AmplifyBranch.keys.privacyType == PrivacyType.open
        let sortInput = QuerySortInput.descending(AmplifyBranch.keys.updatedAt)
        let paginationInput = QueryPaginationInput.page(UInt(page), limit: 100)
        return try await manager.dataStoreRepo.queryBranches(where: predicateInput, sort: sortInput, paginate: paginationInput)
    }
}
