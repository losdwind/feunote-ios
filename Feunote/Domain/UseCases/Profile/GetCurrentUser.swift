//
//  GetCurrentUser.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/29.
//

import Foundation

protocol GetCurrentProfileUseCaseProtocol {
    func execute() async throws -> FeuUser?
}



class GetCurrentProfileUseCase : GetCurrentProfileUseCaseProtocol{

    

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    func execute() async throws -> FeuUser? {

        return manager.dataStoreRepo.feuUser
}
}
