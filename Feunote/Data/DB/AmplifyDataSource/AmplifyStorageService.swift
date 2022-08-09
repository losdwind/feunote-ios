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
                      data: Data, accessLevel:StorageAccessLevel) -> StorageUploadDataOperation
    func downloadImage(key: String, accessLevel:StorageAccessLevel) -> StorageDownloadDataOperation

    func removeImage(key: String, accessLevel:StorageAccessLevel) -> StorageRemoveOperation
}

public class AmplifyStorageService: StorageServiceProtocol {
    

    func uploadImage(key: String,
                      data: Data, accessLevel:StorageAccessLevel) -> StorageUploadDataOperation {
        let options = StorageUploadDataRequest.Options(accessLevel: accessLevel)
        return Amplify.Storage.uploadData(key: key,
                                          data: data,
                                          options: options)
    }

    func downloadImage(key: String, accessLevel:StorageAccessLevel) -> StorageDownloadDataOperation {
        let options = StorageDownloadDataRequest.Options(accessLevel: accessLevel)
        return Amplify.Storage.downloadData(key: key, options: options)
    }

    func removeImage(key: String, accessLevel:StorageAccessLevel) -> StorageRemoveOperation {
        let options = StorageRemoveRequest.Options(accessLevel: accessLevel)
        return Amplify.Storage.remove(key: key,
                                      options: options)
    }
}
