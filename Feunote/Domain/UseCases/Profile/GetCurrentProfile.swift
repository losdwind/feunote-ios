//
//  GetCurrentUser.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/29.
//

import Foundation

class GetCurrentProfileUseCase: GetCurrentProfileUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute() async throws -> AmplifyUser? {
        guard let userID = manager.authRepo.authUser?.userId else {return nil}
        return try await manager.dataStoreRepo.queryUser(byID: userID)
    }
}
