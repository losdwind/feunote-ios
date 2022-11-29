//
//  GetCommentsUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import Foundation
class GetCommentsUseCase: GetCommentsUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(branchID: String) async throws -> [AmplifyComment] {
        return try await manager.dataStoreRepo.queryComments(branchID: branchID)
    }
}
