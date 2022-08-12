//
//  SaveCommit.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Foundation

import Amplify

class SaveCommitUseCase: SaveCommitUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    func execute(commit: AmplifyCommit) async throws {
        guard let userID = manager.authRepo.authUser?.userId else {throw AppError.invalidLoginStatus}
//        if commit.toBranch == nil {
//            guard let branch = try await manager.dataStoreRepo.queryBranch(byID: "defaultBranch_\(userID)") else {throw AppError.itemDoNotExist}
//
//            var newCommit = commit
//            newCommit.toBranch = branch
//            try await manager.dataStoreRepo.saveCommit(newCommit)
//        }else {
//            try await manager.dataStoreRepo.saveCommit(commit)
//        }
        try await manager.dataStoreRepo.saveCommit(commit)

    }
}
