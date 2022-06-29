//
//  GetAllBranches.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/14.
//

import Foundation

import Amplify

protocol GetAllBranchesUseCaseProtocol {
    func execute(page:Int) async throws -> [FeuBranch]
}



class GetAllBranchesUseCase: GetAllBranchesUseCaseProtocol{

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    
    func execute(page: Int) async throws -> [FeuBranch] {
            
        let predicateInput = true as! QueryPredicate
//        AmplifyBranch.keys.owner == manager.dataStoreRepo.amplifyUser
            let sortInput = QuerySortInput.descending(AmplifyBranch.keys.createdAt)
            let paginationInput = QueryPaginationInput.page(UInt(page), limit: 10)
        return try await manager.dataStoreRepo.queryBranches(where: predicateInput, sort: sortInput, paginate: paginationInput)
    }
    
    
    }

