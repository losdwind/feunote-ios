//
//  GetMessagesUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/23.
//

import Foundation
class GetMessagesUseCase: GetMessagesUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(branchID: String) async throws -> [AmplifyMessage] {
        return try await manager.dataStoreRepo.queryMessages(branchID: branchID)
    }
}
