//
//  SaveCommentUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/11/26.
//

import Foundation
import Amplify
class SaveCommentUseCase: SaveCommentUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(branchID: String, content: String?) async throws {
        guard let user = manager.dataStoreRepo.amplifyUser else {
            throw AppError.invalidLoginStatus      }
        guard let branch = try await manager.dataStoreRepo.queryBranch(byID: branchID) else {
            throw AppError.invalidSubmit
        }
        let comment = AmplifyComment(creator: user, toBranch: branch, content: content, createAt: Temporal.DateTime.now())
        try await manager.dataStoreRepo.saveComment(comment: comment)
    }
}
