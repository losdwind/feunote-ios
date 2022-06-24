//
//  DeletePerson.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

protocol DeletePersonUseCaseProtocol {
    func execute(person:Person) async throws
}



class DeletePersonUseCase: DeletePersonUseCaseProtocol{

    

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    
    func execute(person:Person) async throws {
        
        guard let pictureKey = person.avatarURL else {
            return try await manager.dataStoreRepo.deletePerson(person)
        }
        
        try await manager.storageRepo.removeImage(key: pictureKey)
        
    }
    
    
    }
