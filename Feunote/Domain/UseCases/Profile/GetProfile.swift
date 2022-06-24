//
//  GetAllProfiles.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/14.
//

import Foundation
import Amplify

protocol GetProfilesUseCaseProtocol {
    func execute(authUser:AuthUser) async throws -> User
}



class GetProfileUseCase : GetProfilesUseCaseProtocol{

    

    

    
    

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    func execute(authUser:AuthUser) async throws -> User {

        return try await manager.dataStoreRepo.query(User.self, byId: authUser.userId)
}
}
