//
//  GetProfilesByIDsUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/5.
//

import Foundation

import Amplify

class GetProfilesByIDsUseCase: GetProfilesByIDsUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(userIDs: [String]) async throws -> [AmplifyUser?] {
        try await withThrowingTaskGroup(of: AmplifyUser?.self, body: { group -> [AmplifyUser?] in
            var amplifyUsers: [AmplifyUser?] = .init()
            for userID in userIDs {
                group.addTask {
                    try await self.manager.dataStoreRepo.queryUser(byID: userID)
                }
            }
            for try await amplifyUser in group {
                    amplifyUsers.append(amplifyUser)
            }
            return amplifyUsers
        })
    }
}
