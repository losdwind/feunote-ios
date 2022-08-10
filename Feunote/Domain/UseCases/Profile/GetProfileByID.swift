//
//  GetAllProfiles.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/14.
//

import Amplify
import Foundation

class GetProfileByIDUseCase: GetProfileByIDUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(userID: String) async throws -> AmplifyUser {
        return try await manager.dataStoreRepo.queryUser(byID: userID)
    }
}
