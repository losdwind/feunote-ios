//
//  StorageRepositoryImpl.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Foundation
import Amplify
import AmplifyPlugins

class StorageRepositoryImpl:StorageRepositoryProtocol{
    private let storageService:StorageServiceProtocol
    
    init(storageService:StorageServiceProtocol){
        self.storageService = storageService
    }
    
    func uploadImage(key: String, data: Data) -> StorageUploadDataOperation {
        storageService.uploadImage(key: key, data: data)
    }
    
    func downloadImage(key: String) -> StorageDownloadDataOperation {
        storageService.downloadImage(key: key)
    }
    
    func removeImage(key: String) -> StorageRemoveOperation {
        storageService.removeImage(key: key)
    }
    
    
}
