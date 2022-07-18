//
//  GetAllCommits.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/14.
//

import Foundation
import Amplify

protocol GetAllCommitsUseCaseProtocol {
    func execute(page:Int) async throws-> [AmplifyCommit]
}



class GetAllCommitsUseCase : GetAllCommitsUseCaseProtocol{

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }

    func execute(page: Int) async throws -> [AmplifyCommit] {
        
//        guard let user = manager.dataStoreRepo.amplifyUser else {throw AppError.failedToSave}

        let predicateInput:QueryPredicate? = nil
            let sortInput = QuerySortInput.ascending(AmplifyCommit.keys.createdAt)
            let paginationInput = QueryPaginationInput.page(UInt(page), limit: 20)
        
        return try await manager.dataStoreRepo.queryCommits(where: predicateInput, sort: sortInput, paginate: paginationInput)
        
    }
}
