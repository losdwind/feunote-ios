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

    

    private let dataStoreRepo: DataStoreRepositoryProtocol

    init(dataStoreRepo:DataStoreRepositoryProtocol){
        self.dataStoreRepo = dataStoreRepo
    }
    
    
    func execute(existingBranch:Branch?, title:String, description:String, members:[String?]?) async throws -> Branch {
        
        guard let user = manager.dataStoreRepo.user else { return }

        var newBranch:Branch
        
        if existingBranch {
            newBranch = existingBranch!
            newBranch.title = title
            newBranch.description = description
            newBranch.members = members
        } else {
            newBranch = Branch(fromUser: user, title: title, description: description, members:members)
        }
        return try await manager.dataStoreRepo.saveBranch(newBranch)
        
        
    }
    
    
    }
