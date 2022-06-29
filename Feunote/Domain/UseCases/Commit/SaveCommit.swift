//
//  SaveCommit.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

protocol SaveCommitUseCaseProtocol {
    func execute(commit:FeuCommit) async throws
}



class SaveCommitUseCase: SaveCommitUseCaseProtocol{

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    
    func execute(commit:FeuCommit) async throws{
    
        guard let user = manager.dataStoreRepo.amplifyUser else {throw AppError.failedToSave}
        
        try await manager.dataStoreRepo.saveCommit(commit)
    }
    
    
    }
