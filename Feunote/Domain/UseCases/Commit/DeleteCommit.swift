//
//  DeleteCommit.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify


class DeleteCommitUseCase: DeleteCommitUseCaseProtocol{
    
    
    
    private let manager:AppRepositoryManagerProtocol
    
    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    
    func execute(commitID:String) async throws {
        
        try await manager.dataStoreRepo.deleteCommit(commitID)
        
    }
    
    
}



