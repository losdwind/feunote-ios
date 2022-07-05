//
//  GetProfilesByIDsUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/5.
//

import Foundation
import Foundation

import Amplify

protocol GetProfilesByIDsUseCaseProtocol {
    func execute(userIDs:[String]) async throws -> [AmplifyUser]
}



class GetProfilesByIDsUseCase: GetProfilesByIDsUseCaseProtocol{

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    
    func execute(userIDs:[String]) async throws -> [AmplifyUser] {
            
        
        
        
        try await withThrowingTaskGroup(of: AmplifyUser.self, body: { group -> [AmplifyUser] in
            var amplifyUsers:[AmplifyUser] = [AmplifyUser]()
            for userID in userIDs {
                group.addTask {
                    return try await self.manager.dataStoreRepo.queryUser(byID: userID)
                }
            }
            for try await amplifyUser in group {
                amplifyUsers.append(amplifyUser)
            }
            return amplifyUsers
        })
    }
    
    
    }
