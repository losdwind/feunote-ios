//
//  SignOut.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/30.
//

import Foundation
import Amplify

protocol SignOutUseCaseProtocol {
    func execute() async throws -> AuthStep
}



class SignOutUseCase: SignOutUseCaseProtocol{

    

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }

    /// sign into through the authentication service. If first time sign in, it will set up the user model in database.
    func execute() async throws -> AuthStep{
        
        return try await manager.authRepo.signOut()
    }
    
    
    }
