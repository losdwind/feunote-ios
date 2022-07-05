//
//  SaveProfile.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

protocol SaveProfileUseCaseProtocol {
    func execute(user:AmplifyUser) async throws
}



class SaveProfileUseCase: SaveProfileUseCaseProtocol{

    

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    
    func execute(user:AmplifyUser) async throws{

        try await manager.dataStoreRepo.saveUser(user)
    }
    
    
    }
