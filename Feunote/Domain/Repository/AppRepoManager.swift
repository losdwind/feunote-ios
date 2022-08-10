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
    var storageRepo: StorageRepositoryProtocol { get }
    var remoteApiRepo: RemoteApiRepositoryProtocol { get }
    var errorTopic: PassthroughSubject<AmplifyError, Never> { get }
    func configure()
}

class AppRepoManager: AppRepositoryManagerProtocol {
    private init() {}

    static let shared = AppRepoManager()
    let authRepo: AuthRepositoryProtocol = AuthRepositoryImpl(authService: AmplifyAuthService())
    let dataStoreRepo: DataStoreRepositoryProtocol = DataStoreRepositoryImpl(dataStoreService: AmplifyDataStoreService(), storageService: AmplifyStorageService())
    let storageRepo: StorageRepositoryProtocol = StorageRepositoryImpl(storageService: AmplifyStorageService())
    var remoteApiRepo: RemoteApiRepositoryProtocol = RemoteApiRepositoryImpl()

    let errorTopic = PassthroughSubject<AmplifyError, Never>()

    func configure() {
        authRepo.configure()
        dataStoreRepo.configure(authRepo.sessionStatePublisher)
    }
}
