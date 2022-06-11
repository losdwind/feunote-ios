//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import Amplify
import AmplifyPlugins
import Foundation

protocol StorageServiceProtocol {
    func uploadImage(key: String,
                     data: Data) -> StorageUploadDataOperation
    func downloadImage(key: String) -> StorageDownloadDataOperation
    func removeImage(key: String) -> StorageRemoveOperation
}

public class AmplifyStorageServiceManager: StorageServiceProtocol {

    func uploadImage(key: String,
                     data: Data) -> StorageUploadDataOperation {
        let options = StorageUploadDataRequest.Options(accessLevel: .private)
        return Amplify.Storage.uploadData(key: key,
                                          data: data,
                                          options: options)
    }

    func downloadImage(key: String) -> StorageDownloadDataOperation {
        let options = StorageDownloadDataRequest.Options(accessLevel: .private)
        return Amplify.Storage.downloadData(key: key, options: options)
    }

    func removeImage(key: String) -> StorageRemoveOperation {
        let options = StorageRemoveRequest.Options(accessLevel: .private)
        return Amplify.Storage.remove(key: key,
                                      options: options)
    }
}
