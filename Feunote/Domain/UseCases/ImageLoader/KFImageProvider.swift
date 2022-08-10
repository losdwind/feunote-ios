//
//  KFImageProvider.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/8.
//

import Combine
import Foundation
import Kingfisher
class KFImageProvider: ImageDataProvider {
    public var cacheKey: String
    private var manager: AppRepositoryManagerProtocol
    private var subscribers = Set<AnyCancellable>()

    init(key: String,
         manager: AppRepositoryManagerProtocol = AppRepoManager.shared)
    {
        self.cacheKey = key
        self.manager = manager
    }

    public func data(handler: @escaping (Result<Data, Error>) -> Void) {
        let ops = manager.storageRepo.downloadImage(key: cacheKey)
        ops.resultPublisher.sink {
            if case let .failure(storageError) = $0 {
                handler(.failure(storageError))
            }
        }
    receiveValue: { data in
            handler(.success(data))
        }
        .store(in: &subscribers)
    }
}
