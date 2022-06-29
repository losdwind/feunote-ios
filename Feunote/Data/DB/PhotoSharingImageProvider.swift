//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

//import Combine
//import Foundation
//import Kingfisher
//
//class ImageProvider: ImageDataProvider {
//
//    public var cacheKey: String
//    private var storageService: StorageServiceProtocol
//    private var subscribers = Set<AnyCancellable>()
//
//    init(key: String,
//         manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
//        self.cacheKey = key
//        self.storageService = manager.storageRepo
//    }
//
//    public func data(handler: @escaping (Result<Data, Error>) -> Void) {
//        let ops = storageService.downloadImage(key: cacheKey)
//        ops.resultPublisher.sink {
//            if case let .failure(storageError) = $0 {
//                handler(.failure(storageError))
//            }
//        }
//        receiveValue: { data in
//            handler(.success(data))
//        }
//        .store(in: &subscribers)
//    }
//}
