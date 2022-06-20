//
//  GetAllBranches.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/14.
//

import Foundation

import Amplify

protocol GetAllBranchesUseCaseProtocol {
    func execute(page:Int) async throws -> [Branch]
}



class GetAllBranchesUseCase: GetAllBranchesUseCaseProtocol{

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    
    func execute(page: Int) async throws -> [Branch] {
            
        let predicateInput = Branch.keys.fromUser == manager.dataStoreRepo.user?.id
            let sortInput = QuerySortInput.descending(Branch.keys.createdAt)
            let paginationInput = QueryPaginationInput.page(UInt(page), limit: 10)
        return try await manager.dataStoreRepo.query(Branch.self, where: predicateInput, sort: sortInput, paginate: paginationInput)
    }
    
    
    }

