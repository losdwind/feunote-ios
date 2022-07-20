//
//  GetAllCommits.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/14.
//

import Foundation
import Amplify





class GetAllCommitsUseCase : GetAllCommitsUseCaseProtocol{

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }

    func execute(page: Int) async throws -> [AmplifyCommit] {
        
        let predicateInput:QueryPredicate? = nil
            let sortInput = QuerySortInput.descending(AmplifyCommit.keys.updatedAt)
            let paginationInput = QueryPaginationInput.page(UInt(page), limit: 20)
        
        return try await manager.dataStoreRepo.queryCommits(where: predicateInput, sort: sortInput, paginate: paginationInput)
        
    }
}
