//
//  GetImageUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/9.
//

import Foundation
import Amplify

protocol GetImageUseCaseProtocol {
    func execute(key:String) -> StorageDownloadDataOperation
}

class GetImageUseCase: GetImageUseCaseProtocol{

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }


    func execute(key:String) -> StorageDownloadDataOperation {
        return manager.storageRepo.downloadImage(key: key)
    }

}
