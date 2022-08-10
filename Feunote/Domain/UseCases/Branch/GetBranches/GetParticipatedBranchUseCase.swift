//
//  GetParticipatedBranchUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/23.
//

import Amplify
import Foundation

class GetParticipatedBranchesUseCase: GetBranchesUseCaseProtocol {

    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(page: Int) async throws -> [AmplifyBranch] {
        return []
    }
}
