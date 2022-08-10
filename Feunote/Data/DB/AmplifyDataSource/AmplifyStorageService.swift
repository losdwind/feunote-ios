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
                     data: Data, accessLevel: StorageAccessLevel) -> StorageUploadDataOperation
    func downloadImage(key: String) -> StorageDownloadDataOperation

    func removeImage(key: String) -> StorageRemoveOperation
}

public class AmplifyStorageService: StorageServiceProtocol {
    func uploadImage(key: String,
                     data: Data, accessLevel: StorageAccessLevel) -> StorageUploadDataOperation
    {
        let options = StorageUploadDataRequest.Options(accessLevel: accessLevel)
        return Amplify.Storage.uploadData(key: key,
                                          data: data,
                                          options: options)
    }

    func downloadImage(key: String) -> StorageDownloadDataOperation {
        return Amplify.Storage.downloadData(key: key)
    }

    func removeImage(key: String) -> StorageRemoveOperation {
        return Amplify.Storage.remove(key: key)
    }
}
