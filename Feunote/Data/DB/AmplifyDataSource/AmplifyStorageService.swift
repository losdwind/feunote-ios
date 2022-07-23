//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import Amplify
import Foundation
import Combine

protocol StorageServiceProtocol {
    func uploadImage(key: String,
                     data: Data) async throws -> String
    func downloadImage(key: String) async throws -> Data
    func removeImage(key: String) async throws -> String
}

public class AmplifyStorageService: StorageServiceProtocol {
    
    private var cancellables:Set<AnyCancellable> = Set<AnyCancellable>()

    func uploadImage(key: String,
                     data: Data) async throws -> String {
        return try await withCheckedThrowingContinuation({ continuation in
            let options = StorageUploadDataRequest.Options(accessLevel: .private)
            let ops = Amplify.Storage.uploadData(key: key, data: data, options: options)
            ops.resultPublisher.sink(receiveCompletion: { error in
                print(error)
                continuation.resume(throwing: AppError.failedToSaveResource)
            }, receiveValue: { key in
                continuation.resume(returning:key)
            })
            .store(in:&cancellables)


        })
    }

    func downloadImage(key: String) async throws -> Data {
        return try await withCheckedThrowingContinuation({ continuation in
        let options = StorageDownloadDataRequest.Options(accessLevel: .private)
        let ops = Amplify.Storage.downloadData(key: key, options: options)
        ops.resultPublisher.sink(receiveCompletion: { error in
            print(error)
            continuation.resume(throwing: AppError.failedToLoadResource)
        }, receiveValue: { data in
            continuation.resume(returning:data)
        })
        .store(in:&cancellables)
        })
    }

    func removeImage(key: String) async throws -> String {
        return try await withCheckedThrowingContinuation({ continuation in
            let options = StorageRemoveRequest.Options(accessLevel: .private)
            let ops = Amplify.Storage.remove(key: key,
                                             options: options)

            ops.resultPublisher.sink(receiveCompletion: { error in
                print(error)
                                            continuation.resume(throwing: AppError.failedToDeleteResource)
                                        }, receiveValue: {
                                            key in
                                            continuation.resume(returning:key)
                                        })
            .store(in:&cancellables)


        })
    }
}
