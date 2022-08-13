//
//  StorageRepositoryImpl.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Amplify
import Foundation

class StorageRepositoryImpl: StorageRepositoryProtocol {
    private let storageService: StorageServiceProtocol

    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }

    func uploadImage(key: String, data: Data) async throws -> String {


        return try await storageService.uploadImage(key: key, data: data)
    }

    func downloadImage(key: String) async throws -> Data {

        return try await storageService.downloadImage(key: key)
    }

    func removeImage(key: String) async throws -> String {

        return try await storageService.removeImage(key: key)
    }
}
