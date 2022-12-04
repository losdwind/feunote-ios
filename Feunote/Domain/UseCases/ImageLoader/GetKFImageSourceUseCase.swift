//
//  ImageLoader.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/8.
//

import Combine
import Foundation
import Kingfisher
import Amplify
class GetKFImageSource: GetKFImageSourceProtocol {
    func execute(key: String) -> Source {
        return Source.provider(KFImageProvider(key: key))
    }
}

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
                var options = StorageDownloadDataRequest.Options(accessLevel: .private)
                guard let username = manager.authRepo.authUser?.username, let userID = manager.authRepo.authUser?.userId else {
                    handler(.failure(AppError.invalidLoginStatus))
                    return
                }

                if cacheKey.hasPrefix("User/Avatar/"){
                    options = StorageDownloadDataRequest.Options(accessLevel: .protected, targetIdentityId: "\(cacheKey.deletingPrefix("User/Avatar/"))")
                    print("identityID:\(cacheKey.deletingPrefix("User/Avatar/"))")
                }
                let data = try await manager.storageRepo.downloadImage(key: cacheKey, options: options)
                handler(.success(data))
            } catch(let error) {
                handler(.failure(error))
            }
        }
    }
}
//
//class KFImageProvider: ImageDataProvider {
//
//    public var cacheKey: String
//    private var storageService: StorageService
//    private var subscribers = Set<AnyCancellable>()
//
//    init(key: String,
//         manager: ServiceManager = AppServiceManager.shared) {
//        self.cacheKey = key
//        self.storageService = manager.storageService
//    }
//
//    public func data(handler: @escaping (Result<Data, Error>) -> Void) {
//        let ops = storageService.downloadImage(key: cacheKey)
//        ops.resultPublisher.sink {
//            if case let .failure(storageError) = $0 {
//                handler(.failure(storageError))
//            }
//        }
//    receiveValue: { data in
//        handler(.success(data))
//    }
//    .store(in: &subscribers)
//    }
//}
