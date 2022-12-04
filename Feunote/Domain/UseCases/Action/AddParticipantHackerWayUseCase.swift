//
//  AddParticipantHackerWayUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/11/30.
//

import Foundation
class AddParticipantHackerWayUseCase: AddParticipantHackerWayUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(targetUsers:[AmplifyUser], branchID: String) async throws {
        guard let currentUser = manager.authRepo.authUser?.userId else {
            throw AppError.invalidLoginStatus      }
        guard let branch = try await self.manager.dataStoreRepo.queryBranch(byID: branchID) else {
            throw AppError.invalidSubmit
        }

        try await withThrowingTaskGroup(of: Void.self, body: { group in
            for targetUser in targetUsers {
                group.addTask {
                    let action = AmplifyAction(creator: targetUser, toBranch: branch, actionType: ActionType.participate.rawValue, content: nil)
                    let returnedAction = try await self.manager.dataStoreRepo.saveAction(action: action)
                    print("registered participants: \(returnedAction.creator.username)")
                    return
                }
            }
            for try await _ in group {
            }
            return

        })

    }
}
