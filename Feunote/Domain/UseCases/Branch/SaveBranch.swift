//
//  SaveBranch.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

protocol SaveBranchUseCaseProtocol {
    func execute(existingBranch:Branch?, title:String, description:String, members:[String?]?) async throws -> Branch
}



class SaveBranchUseCase: SaveBranchUseCaseProtocol{

    

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    func execute(existingBranch:Branch?, title:String, description:String, members:[String?]?) async throws -> Branch {
        
        guard let user = manager.dataStoreRepo.user else { throw AppError.failedToSave}

        var newBranch:Branch
        
        if (existingBranch != nil) {
            newBranch = existingBranch!
            newBranch.title = title
            newBranch.description = description
            newBranch.members = members
        } else {
            newBranch = Branch(fromUser: user, members:members, title: title, description: description)
        }
        return try await manager.dataStoreRepo.saveBranch(newBranch)
        
        
    }
    
    
    }
