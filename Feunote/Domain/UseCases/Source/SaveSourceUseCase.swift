//
//  SaveSourceUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/11/26.
//

import Foundation
import Amplify
class SaveSourceUseCase: SaveSourceUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(sourceType: SourceType, sourceData: String) async throws {
        guard let user = manager.dataStoreRepo.amplifyUser else {
            throw AppError.invalidLoginStatus
        }

        let source = AmplifySource(creatorID: user.id, createAt: Temporal.DateTime.now(), sourceType: sourceType.rawValue, sourceData: sourceData)
        try await manager.dataStoreRepo.saveSource(source: source)
    }
}
