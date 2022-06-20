//
//  DeleteMoment.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

protocol DeleteMomentUseCaseProtocol {
    func execute(moment:Moment) async throws -> [Branch]
}



class DeleteMomentUseCase: DeleteMomentUseCaseProtocol{
    
    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    func execute(moment:Moment) async throws {
        
        
        guard let pictureKeys = moment.imageURLs else { try await manager.dataStoreRepo.deleteMoment(moment)}
        
        try await withThrowingTaskGroup(of: String.self){ group in
            
            for key in pictureKeys {
                
                group.addTask{
                    return try await manager.storageRepo.removeImage(key: key)
                }
                
            }
        }
    }
    
    
}
