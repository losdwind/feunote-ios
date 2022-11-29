//
//  DeleteMessageUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import Foundation

class DeleteMessageUseCase: DeleteMessageUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(message: AmplifyMessage) async throws {
        try await manager.dataStoreRepo.deleteMessage(message: message)
    }
}
