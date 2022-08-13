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
        cacheKey = key
        self.manager = manager
    }

    public func data(handler: @escaping (Result<Data, Error>) -> Void) {
        Task {
            do {
                let data = try await manager.storageRepo.downloadImage(key: cacheKey)
                handler(.success(data))
            } catch(let error) {
                handler(.failure(error))

            }
        }

    }
}
