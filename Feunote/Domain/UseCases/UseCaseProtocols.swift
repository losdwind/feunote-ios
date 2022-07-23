//
//  UseCaseProtocols.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/20.
//

import Foundation

// MARK: - Commit

protocol DeleteCommitUseCaseProtocol {
    func execute(commitID: String) async throws
}

protocol SaveCommitUseCaseProtocol {
    func execute(commit: AmplifyCommit) async throws
}

protocol GetAllCommitsUseCaseProtocol {
    func execute(page: Int) async throws -> [AmplifyCommit]
}

// MARK: - Auth

protocol ConfirmSignUpUseCaseProtocol {
    func execute(username: String, password: String, confirmationCode: String) async throws -> AuthStep
}

protocol SignInUseCaseProtocol {
    func execute(username: String, password: String) async throws -> AuthStep
}

protocol SignUpUseCaseProtocol {
    func execute(username: String, email: String, password: String) async throws -> AuthStep
}

protocol SignOutUseCaseProtocol {
    func execute() async throws -> AuthStep
}

// MARK: - Profile

protocol DeleteProfileUseCaseProtocol {
    func execute() async throws
}

protocol SaveProfileUseCaseProtocol {
    func execute(user: AmplifyUser) async throws
}

protocol GetProfileByIDUseCaseProtocol {
    func execute(userID: String) async throws -> AmplifyUser
}

protocol GetCurrentProfileUseCaseProtocol {
    func execute() async throws -> AmplifyUser?
}

protocol GetProfilesByIDsUseCaseProtocol {
    func execute(userIDs: [String]) async throws -> [AmplifyUser]
}

// MARK: - Branch

protocol DeleteBranchUseCaseProtocol {
    func execute(branchID: String) async throws
}

protocol SaveBranchUseCaseProtocol {
    func execute(branch: AmplifyBranch) async throws
}

protocol GetOwnedBranchesUseCaseProtocol {
    func execute(page: Int) async throws -> [AmplifyBranch]
}

protocol GetOpenBranchesUseCaseProtocol {
    func execute(page: Int) async throws -> [AmplifyBranch]
}

protocol GetOwnedBranchByIDUseCaseProtocol {
    func execute(branchID: String) async throws -> AmplifyBranch
}

protocol GetOpenBranchByIDUseCaseProtocol {
    func execute(branchID: String) async throws -> AmplifyBranch
}

protocol GetParticipatedBranchesUseCaseProtocol {
    func execute() async throws -> [AmplifyBranch]
}

protocol GetNonPrivateBranchesUseCaseProtocol {
    func execute(page: Int) async throws -> [AmplifyBranch]
}

// MARK: - Action

protocol SaveActionUseCaseProtocol {
    func execute(action: AmplifyAction) async throws
}

protocol DeleteActionUseCaseProtocol {
    func execute(action: AmplifyAction) async throws
}

protocol GetCommentsUseCaseProtocol {
    func execute(branchID: String) async throws -> [AmplifyAction]
}

protocol GetMessagesUseCaseProtocol {
    func execute(branchID: String) async throws -> [AmplifyAction]
}
