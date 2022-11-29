//
//  GetOpenBranchesUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import Amplify
import Foundation

class GetOpenBranchesUseCase: GetBranchesUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(page: Int) async throws -> [AmplifyBranch] {
        guard (manager.authRepo.authUser?.userId) != nil else {throw AppError.invalidLoginStatus}
        let predicateInput: QueryPredicate? = AmplifyBranch.keys.privacyType == PrivacyType.open
        let sortInput = QuerySortInput.descending(AmplifyBranch.keys.updatedAt)
        let paginationInput = QueryPaginationInput.page(UInt(page), limit: 100)
        return try await manager.dataStoreRepo.queryBranches(where: predicateInput, sort: sortInput, paginate: paginationInput)
    }
}
