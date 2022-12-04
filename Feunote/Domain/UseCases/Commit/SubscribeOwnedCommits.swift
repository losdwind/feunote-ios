//
//  SubscribeOwnedCommits.swift
//  Feunote
//
//  Created by Losd wind on 2022/11/21.
//

import Amplify
import Foundation
import Combine
class SubscribeOwnedCommitsUseCase: SubscribeCommitsUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    // MARK: -TODO check the 100 limit
    func execute(page: Int) -> AnyPublisher<DataStoreQuerySnapshot<AmplifyCommit>, DataStoreError>{
        guard let username = manager.authRepo.authUser?.username else {
            return manager.dataStoreRepo.observeQueryCommits(where: nil, sort: nil, paginate: QueryPaginationInput.page(0, limit: 0))
        }
        let predicateInput: QueryPredicate? = AmplifyCommit.keys.owner == username
        let sortInput = QuerySortInput.descending(AmplifyCommit.keys.updatedAt)
        let paginationInput: QueryPaginationInput? = QueryPaginationInput.page(UInt(page), limit: 100)

        return manager.dataStoreRepo.observeQueryCommits(where: predicateInput, sort: sortInput, paginate: paginationInput)
    }
}
