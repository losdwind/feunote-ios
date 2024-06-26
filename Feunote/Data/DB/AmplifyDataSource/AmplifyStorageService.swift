//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import Amplify
import Combine
import Foundation

protocol StorageServiceProtocol {
    func uploadImage(key: String,
                     data: Data, options: StorageUploadDataRequest.Options) async throws -> String
    func downloadImage(key: String,options:StorageDownloadDataRequest.Options) async throws -> Data
    func removeImage(key: String) async throws -> String
    func downloadImage(key: String, options:StorageDownloadDataRequest.Options) -> StorageDownloadDataOperation
}

public class AmplifyStorageService: StorageServiceProtocol {
    private var cancellables: Set<AnyCancellable> = .init()

    func uploadImage(key: String,
                     data: Data, options:StorageUploadDataRequest.Options) async throws -> String
    {
        return try await withCheckedThrowingContinuation { continuation in
            let ops = Amplify.Storage.uploadData(key: key, data: data, options: options)
            ops.resultPublisher.sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        print(error)
                        continuation.resume(throwing: error)
                    case .finished:
                        print("uploaded \(key) to s3")
                }

            }, receiveValue: { key in
                continuation.resume(returning: key)
            })
            .store(in: &cancellables)
        }
    }

    func downloadImage(key: String,options:StorageDownloadDataRequest.Options) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            let ops = Amplify.Storage.downloadData(key: key, options: options)
            ops.resultPublisher.sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        print(error)
                        continuation.resume(throwing: error)
                    case .finished:
                        print("downloaded \(key) form s3")
                }
            }, receiveValue: { data in
                continuation.resume(returning: data)
            })
            .store(in: &cancellables)
        }
    }


    func downloadImage(key: String,options:StorageDownloadDataRequest.Options) -> StorageDownloadDataOperation {
        return Amplify.Storage.downloadData(key: key, options: options)
    }

    func removeImage(key: String) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            let options = StorageRemoveRequest.Options(accessLevel: .private)
            let ops = Amplify.Storage.remove(key: key,
                                             options: options)

            ops.resultPublisher.sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        print("removed \(key) from s3")
                    case .failure(let error):
                        print(error)
                        continuation.resume(throwing: error)
                }

            }, receiveValue: {
                key in
                continuation.resume(returning: key)
            })
            .store(in: &cancellables)
        }
    }
}
