//
//  StorageRepositoryProtocol.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Foundation
import Amplify

protocol StorageRepositoryProtocol{
    func uploadImage(key: String, data: Data, accessLevel:StorageAccessLevel) -> StorageUploadDataOperation
    func downloadImage(key: String, accessLevel:StorageAccessLevel) -> StorageDownloadDataOperation
    func removeImage(key: String, accessLevel:StorageAccessLevel) -> StorageRemoveOperation
}
