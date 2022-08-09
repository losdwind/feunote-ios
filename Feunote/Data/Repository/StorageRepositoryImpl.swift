//
//  StorageRepositoryImpl.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Foundation
import Combine
import Amplify
import Kingfisher

class StorageRepositoryImpl:StorageRepositoryProtocol{
    private let storageService:StorageServiceProtocol

    init(storageService:StorageServiceProtocol){
        self.storageService = storageService
    }
    
    func uploadImage(key: String, data: Data, accessLevel:StorageAccessLevel) -> StorageUploadDataOperation {
//        return try await withCheckedThrowingContinuation({ continuation in
//            let ops = storageService.uploadImage(key: key, data: data)
//            ops.resultPublisher.sink(receiveCompletion: { _ in
//                continuation.resume(throwing: AppError.failedToLoadResource)
//            }, receiveValue: { key in
//                continuation.resume(returning:key)
//            })
//            .store(in:&subscribers)
//
//
//        })
        
        return storageService.uploadImage(key: key, data:data, accessLevel: accessLevel)
        
    }
    
    func downloadImage(key: String, accessLevel:StorageAccessLevel) -> StorageDownloadDataOperation {
//        return try await withCheckedThrowingContinuation({ continuation in
//            let ops = storageService.downloadImage(key: key)
//            ops.resultPublisher.sink(receiveCompletion: { _ in
//                continuation.resume(throwing: AppError.failedToLoadResource)
//            }, receiveValue: { data in
//                continuation.resume(returning:data)
//            })
//            .store(in:&subscribers)
//
//
//        })
        return storageService.downloadImage(key: key, accessLevel:accessLevel)
    }
    
    func removeImage(key: String, accessLevel:StorageAccessLevel) -> StorageRemoveOperation {
//        return try await withCheckedThrowingContinuation({ continuation in
//            let ops = storageService.removeImage(key: key)
//
//            ops.resultPublisher.sink(receiveCompletion: { _ in
//                                            continuation.resume(throwing: AppError.failedToDeleteResource)
//                                        }, receiveValue: {
//                                            key in
//                                            continuation.resume(returning:key)
//                                        })
//            .store(in:&subscribers)
//
//
//        })
        return storageService.removeImage(key: key, accessLevel:accessLevel)
    }




    
}



