//
//  SaveActionUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

class SaveActionUseCase: SaveActionUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(branchID: String, actionType: ActionType, content: String?) async throws {
        guard let user = manager.dataStoreRepo.amplifyUser else {
            throw AppError.invalidLoginStatus      }
        guard let branch = try await manager.dataStoreRepo.queryBranch(byID: branchID) else {
            throw AppError.invalidSubmit
        }
        let action = AmplifyAction(creator: user, toBranch: branch, actionType: actionType, content: content)
        try await manager.dataStoreRepo.saveAction(action: action)
    }
}
