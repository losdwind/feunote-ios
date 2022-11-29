//
//  SubscribeMessagesUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/11/23.
//

import Foundation
import Amplify
import Combine
class SubscribeMessagesUseCase: SubscribeMessagesUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(branchID: String, page:Int) -> AnyPublisher<DataStoreQuerySnapshot<AmplifyMessage>, DataStoreError> {

        print("branchID \(branchID)")
        let predicate = (AmplifyMessage.keys.toBranch.eq(branchID))
        let sortInput = QuerySortInput.ascending(AmplifyMessage.keys.createdAt)
        let paginationInput: QueryPaginationInput? = QueryPaginationInput.page(UInt(page), limit: 100)


        return manager.dataStoreRepo.observeQueryMessages(where: predicate, sort: sortInput, paginate: paginationInput)

    }
}
