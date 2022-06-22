//
//  SavePerson.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

protocol SavePersonUseCaseProtocol {
    func execute(existingPerson:Person?, description:String, name:String, avatarImage:UIImage?) async throws -> Person
}



class SavePersonUseCase: SavePersonUseCaseProtocol{

    

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    
    func execute(existingPerson:Person?, description:String, name:String, avatarImage:UIImage?) async throws -> Person{
        
        guard let user = manager.dataStoreRepo.user else { throw AppAuthError.invalidInfo}
        
        var newPerson:Person
        if (existingPerson != nil) {
            newPerson = existingPerson!
            newPerson.description = description
        }else {
            newPerson = Person(fromUser: user, description: description, name: name)
    }
        if (avatarImage != nil) {
            let avatarPictureKey = "\(user.id)_person_\(newPerson.name)_index"
            guard let pngData = avatarImage.pngFlattened(isOpaque: true) else {
                throw AppStorageError.fileCompressionError}
            
            try await manager.storageRepo.uploadImage(key: avatarPictureKey, data: pngData)
        }
        
        return try await manager.dataStoreRepo.savePerson(newPerson)
        
    
    
    }
}
