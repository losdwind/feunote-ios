//
//  GetUserByUsername.swift
//  Feunote
//
//  Created by Losd wind on 2022/11/30.
//

import Amplify
import Foundation

class GetUserByUsernameUseCase: GetUserByUsernameUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(username: String) async throws -> AmplifyUser? {
        let predicate = AmplifyUser.keys.username == username
        return try await manager.dataStoreRepo.queryUsers(where: predicate, sort: nil, paginate: nil).first
    }
}
