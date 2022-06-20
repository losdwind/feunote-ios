//
//  DeleteProfile.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

protocol DeleteProfileUseCaseProtocol {
    func execute() async throws -> [Branch]
}



class DeleteProfileUseCase: DeleteProfileUseCaseProtocol{

    

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    
    func execute() async throws {
        try await authRepo.signOut()
        // more logic shall be added.
    }
    
    
    }




