//
//  SaveBranch.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

protocol SaveBranchUseCaseProtocol {
    func execute(branch:FeuBranch) async throws
}



class SaveBranchUseCase: SaveBranchUseCaseProtocol{

    

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    func execute(branch:FeuBranch) async throws{
        guard let user = manager.dataStoreRepo.amplifyUser else {throw AppError.failedToSave}
        
        try await manager.dataStoreRepo.saveBranch(branch)
       
        
        
    }
    
    
    }
