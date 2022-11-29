//
//  DeleteCommentUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import Foundation

class DeleteCommentUseCase: DeleteCommentUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(comment: AmplifyComment) async throws {
        try await manager.dataStoreRepo.deleteComment(comment: comment)
    }
}
