//
//  GetNonPrivateBranchesUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/23.
//

import Foundation
import Foundation
import Amplify

class GetNonPrivateBranchesUseCase: GetNonPrivateBranchesUseCaseProtocol{

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    
    func execute(page: Int) async throws -> [AmplifyBranch] {
            
        let predicateInput:QueryPredicate? = AmplifyBranch.keys.privacyType != PrivacyType.private
        let sortInput = QuerySortInput.descending(AmplifyBranch.keys.updatedAt)
            let paginationInput = QueryPaginationInput.page(UInt(page), limit: 20)
        return try await manager.dataStoreRepo.queryBranches(where: predicateInput, sort: sortInput, paginate: paginationInput)
    }
    
    }
