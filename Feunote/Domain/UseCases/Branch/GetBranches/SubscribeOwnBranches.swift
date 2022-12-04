//
//  SubscribeOwnBranches.swift
//  Feunote
//
//  Created by Losd wind on 2022/11/21.
//

import Foundation
import Foundation

import Amplify
import Combine
class SubscribeOwnedBranchesUseCase: SubscribeBranchesUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(page: Int) -> AnyPublisher<DataStoreQuerySnapshot<AmplifyBranch>, DataStoreError> {
        guard let username = manager.authRepo.authUser?.username, let userID = manager.authRepo.authUser?.userId else {
            return manager.dataStoreRepo.observeQueryBranches(where: nil, sort: nil, paginate: QueryPaginationInput.page(0, limit: 0))
        }
        let predicateInput: QueryPredicate? = AmplifyBranch.keys.owner == username
        let sortInput = QuerySortInput.descending(AmplifyBranch.keys.updatedAt)
        let paginationInput = QueryPaginationInput.page(UInt(page), limit: 100)
        return  manager.dataStoreRepo.observeQueryBranches(where: predicateInput, sort: sortInput, paginate: paginationInput)
    }
}
