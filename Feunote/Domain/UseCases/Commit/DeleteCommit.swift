//
//  DeleteCommit.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

protocol DeleteCommitUseCaseProtocol {
    func execute(commit:FeuCommit) async throws
}



class DeleteCommitUseCase: DeleteCommitUseCaseProtocol{

    

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    
    func execute(commit:FeuCommit) async throws {
        try await manager.dataStoreRepo.deleteCommit(commit.id)
        
    }
    
    
    }
