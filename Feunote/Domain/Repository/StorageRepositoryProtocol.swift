//
//  StorageRepositoryProtocol.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Foundation
import Amplify

protocol StorageRepositoryProtocol{
    func uploadImage(key: String, data: Data) async await -> String
    func downloadImage(key: String) async throws -> Data
    func removeImage(key: String) async throws-> String
}
