//
//  FakeUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/20.
//

import Amplify
import Foundation

// MARK: - Commit

class FakeGetAllCommitsUseCase: GetCommitsUseCaseProtocol {
    func execute(page _: Int) async throws -> [AmplifyCommit] {
        return [fakeAmplifyMoment1, fakeAmplifyMoment2, fakeAmplifyTodo1, fakeAmplifyTodo2, fakeAmplifyPerson1, fakeAmplifyPerson2]
    }
}

class FakeDeleteCommitUseCase: DeleteCommitUseCaseProtocol {
    func execute(commitID _: String) async throws {
        print("delete success")
    }
}

class FakeSaveCommitUseCase: SaveCommitUseCaseProtocol {
    func execute(commit _: AmplifyCommit) async throws {
        print("save success")
    }
}

// MARK: - Auth

class FakeConfirmSignUpUseCase: ConfirmSignUpUseCaseProtocol {
    func execute(username _: String, password _: String, confirmationCode _: String) async throws -> AuthStep {
        print("confirm Sign Up success")
        return AuthStep.signIn
    }
}

class FakeSignInUseCase: SignInUseCaseProtocol {
    func execute(username _: String, password _: String) async throws -> AuthStep {
        print("Sign In success")
        return AuthStep.done
    }
}

class FakeSocialSignInUseCase: SocialSignInUseCaseProtocol {
    func execute(socialSignInType _: AuthProvider, presentationAnchor _: AuthUIPresentationAnchor) async throws -> AuthStep {
        print("Social Sign In success")
        return AuthStep.done
    }
}

class FakeSignUpUseCase: SignUpUseCaseProtocol {
    func execute(username _: String, email _: String, password _: String) async throws -> AuthStep {
        print("Sign Up success")
        return AuthStep.confirmSignUp
    }
}

class FakeSignOutUseCase: SignOutUseCaseProtocol {
    func execute() async throws -> AuthStep {
        print("Sign Out success")
        return AuthStep.signIn
    }
}

// MARK: - Profile

class FakeDeleteProfileUseCase: DeleteProfileUseCaseProtocol {
    func execute() async throws {
        print("Delete Profile success")
    }
}

class FakeSaveProfileUseCase: SaveProfileUseCaseProtocol {
    func execute(user _: AmplifyUser) async throws {
        print("Save Profile success")
    }
}

class FakeGetProfileByIDUseCase: GetProfileByIDUseCaseProtocol {
    func execute(userID _: String) async throws -> AmplifyUser? {
        print("Get Profile By ID success")
        return fakeAmplifyUser2
    }
}

class FakeGetCurrentProfileUseCase: GetCurrentProfileUseCaseProtocol {
    func execute() async throws -> AmplifyUser? {
        print("Get Current Profile success")
        return fakeAmplifyUser1
    }
}

class FakeGetProfilesByIDsUseCase: GetProfilesByIDsUseCaseProtocol {
    func execute(userIDs _: [String]) async throws -> [AmplifyUser?] {
        return [fakeAmplifyUser1, fakeAmplifyUser2]
    }
}

// MARK: - Branch

class FakeDeleteBranchUseCase: DeleteBranchUseCaseProtocol {
    func execute(branchID _: String) async throws {
        print("Delete Branch success")
    }
}

class FakeSaveBranchUseCase: SaveBranchUseCaseProtocol {
    func execute(branch _: AmplifyBranch) async throws {
        print("Save Branch success")
    }
}

class FakeGetOwnedBranchesUseCase: GetBranchesUseCaseProtocol {
    func execute(page _: Int) async throws -> [AmplifyBranch] {
        print("Get Owned Branches success")

        return [fakeAmplifyBranchPrivate1, fakeAmplifyBranchOpen1]
    }
}

class FakeGetOpenBranchesUseCase: GetBranchesUseCaseProtocol {
    func execute(page _: Int) async throws -> [AmplifyBranch] {
        print("Get Open Branches success")
        return [fakeAmplifyBranchOpen1]
    }
}

class FakeGetOwnedBranchByIDUseCase: GetBranchByIDUseCaseProtocol {
    func execute(branchID _: String) async throws -> AmplifyBranch? {
        print("Get Owned Branch By ID success")

        return fakeAmplifyBranchOpen1
    }
}

class FakeGetOpenBranchByIDUseCase: GetBranchByIDUseCaseProtocol {
    func execute(branchID _: String) async throws -> AmplifyBranch? {
        print("Get Open Branch By ID success")

        return fakeAmplifyBranchOpen1
    }
}

class FakeGetParticipatedBranchesUseCase: GetBranchesUseCaseProtocol {
    func execute(page _: Int = 0) async throws -> [AmplifyBranch] {
        print("Get Participated Branches success")

        return [fakeAmplifyBranchOpen1]
    }
}

class FakeGetNonPrivateBranchesUseCase: GetBranchesUseCaseProtocol {
    func execute(page _: Int) async throws -> [AmplifyBranch] {
        return [fakeAmplifyBranchOpen1]
    }
}

// MARK: - Action

class FakeSaveActionUseCase: SaveActionUseCaseProtocol {
    func execute(branchID _: String, actionType _: ActionType, content _: String?) async throws {
        print("Save Action success")
    }
}

class FakeDeleteActionUseCase: DeleteActionUseCaseProtocol {
    func execute(action _: AmplifyAction) async throws {
        print("Delete Action success")
    }
}

class FakeGetCommentsUseCase: GetCommentsUseCaseProtocol {
    func execute(branchID _: String) async throws -> [AmplifyAction] {
        return [fakeActionComment1, fakeActionComment2]
    }
}

class FakeGetMessagesUseCase: GetMessagesUseCaseProtocol {
    func execute(branchID _: String) async throws -> [AmplifyAction] {
        return [fakeActionMessage1, fakeActionMessage2]
    }
}
