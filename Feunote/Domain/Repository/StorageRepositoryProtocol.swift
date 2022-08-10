//
//  StorageRepositoryProtocol.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Amplify
import Foundation

protocol StorageRepositoryProtocol {
    func uploadImage(key: String, data: Data, accessLevel: StorageAccessLevel) -> StorageUploadDataOperation
    func downloadImage(key: String) -> StorageDownloadDataOperation
    func removeImage(key: String) -> StorageRemoveOperation
}
