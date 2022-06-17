//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import Amplify
import Combine
import Kingfisher

protocol AppRepositoryManagerProtocol {
    var authRepo: AuthRepositoryProtocol { get }
    var dataStoreRepo: DataStoreRepositoryProtocol { get }
    var storageService: StorageRepositoryProtocol { get }
    var errorTopic: PassthroughSubject<AmplifyError, Never> { get }
    func configure()
}

class AppRepositoryManager: AppRepositoryManagerProtocol {

    private init() {
    }

    static let shared = AppRepositoryManager()

    let authRepo: AuthRepositoryProtocol = AuthRepositoryImpl(authService: AmplifyAuthServiceManager())
    let dataStoreRepo: DataStoreRepositoryProtocol = DataStoreRepositoryImpl(dataStoreService: AmplifyDataStoreServiceManager())
    let storageService: StorageRepositoryProtocol = StorageRepositoryImpl(storageService: AmplifyStorageServiceManager())
    let errorTopic = PassthroughSubject<AmplifyError, Never>()

    func configure() {
        authRepo.configure()
        dataStoreRepo.configure(authRepo.sessionStatePublisher)
    }
}
