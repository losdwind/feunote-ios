//
//  UseCaseProtocols.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/20.
//

import Amplify
import Foundation
import Kingfisher
import UIKit

// MARK: - Commit

protocol DeleteCommitUseCaseProtocol {
    func execute(commitID: String) async throws
}

protocol SaveCommitUseCaseProtocol {
    func execute(commit: AmplifyCommit) async throws
}

protocol GetCommitsUseCaseProtocol {
    func execute(page: Int) async throws -> [AmplifyCommit]
}

// MARK: - Auth

protocol ConfirmSignUpUseCaseProtocol {
    func execute(username: String, password: String, confirmationCode: String) async throws -> AuthStep
}

protocol SignInUseCaseProtocol {
    func execute(username: String, password: String) async throws -> AuthStep
}

protocol SocialSignInUseCaseProtocol {
    func execute(socialSignInType: AuthProvider, presentationAnchor: AuthUIPresentationAnchor) async throws -> AuthStep
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
    func execute(userID: String) async throws -> AmplifyUser?
}

protocol GetCurrentProfileUseCaseProtocol {
    func execute() async throws -> AmplifyUser?
}

protocol GetProfilesByIDsUseCaseProtocol {
    func execute(userIDs: [String]) async throws -> [AmplifyUser?]
}

// MARK: - Branch

protocol DeleteBranchUseCaseProtocol {
    func execute(branchID: String) async throws
}

protocol SaveBranchUseCaseProtocol {
    func execute(branch: AmplifyBranch) async throws
}

protocol GetBranchesUseCaseProtocol {
    func execute(page: Int) async throws -> [AmplifyBranch]
}

protocol GetParticipatedBranchesUseCaseProtocol {
    func execute(userID:String) async throws -> [AmplifyBranch]
}

protocol GetBranchByIDUseCaseProtocol {
    func execute(branchID: String) async throws -> AmplifyBranch?
}

// MARK: - Action

protocol SaveActionUseCaseProtocol {
    func execute(branchID: String, actionType: ActionType, content: String?) async throws
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

// Remote Api
protocol GetBetterLifeIndexUseCaseProtocol {
    func execute(location: String) async -> BetterLifeIndexData?
}

protocol GetKFImageSourceUseCaseProtocol {
    func execute(key: String) -> Source
}

protocol SaveProfileImageUseCaseProtocol {
    func execute(image: UIImage) async throws -> String
}
