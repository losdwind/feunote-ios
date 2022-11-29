//
//  GetSubscribedBranchesUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/11/24.
//

import Amplify
import Foundation

class GetSubscribedBranchesUseCase: GetBranchesUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(page: Int) async throws -> [AmplifyBranch] {
        guard let userID = manager.authRepo.authUser?.userId else {throw AppError.invalidLoginStatus}

        let predicateInput1 = AmplifyAction.keys.creator.eq(userID) && AmplifyAction.keys.actionType.eq(ActionType.sub.rawValue)

        let subs = try await manager.dataStoreRepo.querySubs(where: predicateInput1)
        return subs.map { $0.toBranch}
    }
}
