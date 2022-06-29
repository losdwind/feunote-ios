//
//  GetAllCommits.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/14.
//

import Foundation
import Amplify

protocol GetAllCommitsUseCaseProtocol {
    func execute(page:Int) async throws-> [FeuCommit]
}



class GetAllCommitsUseCase : GetAllCommitsUseCaseProtocol{

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }

    func execute(page: Int) async throws -> [FeuCommit] {
        
        guard let user = manager.dataStoreRepo.amplifyUser else {throw AppError.failedToSave}

        let predicateInput = true as! QueryPredicate
//        AmplifyCommit.CodingKeys.owner == user
            let sortInput = QuerySortInput.descending(AmplifyCommit.keys.createdAt)
            let paginationInput = QueryPaginationInput.page(UInt(page), limit: 10)
        
        return try await manager.dataStoreRepo.queryCommits(where: predicateInput, sort: sortInput, paginate: paginationInput)
        
    }
}
