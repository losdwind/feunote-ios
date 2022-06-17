//
//  StorageRepositoryProtocol.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Foundation
import Amplify

protocol StorageRepositoryProtocol{
    func uploadImage(key: String,
                     data: Data) -> StorageUploadDataOperation
    func downloadImage(key: String) -> StorageDownloadDataOperation
    func removeImage(key: String) -> StorageRemoveOperation
}