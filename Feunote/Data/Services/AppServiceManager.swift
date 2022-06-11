//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import Amplify
import Combine
import Kingfisher

protocol AppServiceManagerProtocol {
    var authService: AuthServiceProtocol { get }
    var dataStoreService: DataStoreServiceProtocol { get }
    var storageService: StorageServiceProtocol { get }
    var errorTopic: PassthroughSubject<AmplifyError, Never> { get }
    func configure()
}

class AppServiceManager: AppServiceManagerProtocol {

    private init() {}

    static let shared = AppServiceManager()

    let authService: AuthServiceProtocol = AmplifyAuthServiceManager()
    let dataStoreService: DataStoreServiceProtocol = AmplifyDataStoreServiceManager()
    let storageService: StorageServiceProtocol = AmplifyStorageServiceManager()
    let errorTopic = PassthroughSubject<AmplifyError, Never>()

    func configure() {
        authService.configure()
        dataStoreService.configure(authService.sessionStatePublisher)
    }
}
