//
//  StorageRepositoryImpl.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Foundation
import Combine
import Amplify
import AmplifyPlugins

class StorageRepositoryImpl:StorageRepositoryProtocol{
    private let storageService:StorageServiceProtocol
    private var subscribers = Set<AnyCancellable>()

    init(storageService:StorageServiceProtocol){
        self.storageService = storageService
    }
    
    func uploadImage(key: String, data: Data) async throws -> String {
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
        
        return try await storageService.uploadImage(key: key, data: data)
        
    }
    
    func downloadImage(key: String) async throws -> Data {
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
        return try await storageService.downloadImage(key: key)
    }
    
    func removeImage(key: String) async throws-> String {
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
        return try await storageService.removeImage(key: key)
    }
    
    
}

