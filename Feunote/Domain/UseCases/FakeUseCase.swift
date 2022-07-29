//
//  FakeUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/20.
//

import Foundation

// MARK: - Commit

class FakeGetAllCommitsUseCase: GetAllCommitsUseCaseProtocol {
    func execute(page: Int) async throws -> [AmplifyCommit] {
        return [fakeAmplifyMoment1, fakeAmplifyTodo1, fakeAmplifyPerson1]
    }
}

class FakeDeleteCommitUseCase: DeleteCommitUseCaseProtocol {
    func execute(commitID: String) async throws {
        print("delete success")
    }
}

class FakeSaveCommitUseCase: SaveCommitUseCaseProtocol {
    func execute(commit: AmplifyCommit) async throws {
        print("save success")
    }
}

// MARK: - Auth

class FakeConfirmSignUpUseCase: ConfirmSignUpUseCaseProtocol {
    func execute(username: String, password: String, confirmationCode: String) async throws -> AuthStep {
        print("confirm Sign Up success")
        return AuthStep.signIn
    }
}

class FakeSignInUseCase: SignInUseCaseProtocol {
    func execute(username: String, password: String) async throws -> AuthStep {
        print("Sign In success")
        return AuthStep.done
    }
}

class FakeSignUpUseCase: SignUpUseCaseProtocol {
    func execute(username: String, email: String, password: String) async throws -> AuthStep {
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
    func execute(user: AmplifyUser) async throws {
        print("Save Profile success")
    }
}

class FakeGetProfileByIDUseCase: GetProfileByIDUseCaseProtocol {
    func execute(userID: String) async throws -> AmplifyUser {
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
    func execute(userIDs: [String]) async throws -> [AmplifyUser] {
        return [fakeAmplifyUser1, fakeAmplifyUser2]
    }
}

// MARK: - Branch

class FakeDeleteBranchUseCase: DeleteBranchUseCaseProtocol {
    func execute(branchID: String) async throws {
        print("Delete Branch success")
    }
}

class FakeSaveBranchUseCase: SaveBranchUseCaseProtocol {
    func execute(branch: AmplifyBranch) async throws {
        print("Save Branch success")
    }
}

class FakeGetOwnedBranchesUseCase: GetOwnedBranchesUseCaseProtocol {
    func execute(page: Int) async throws -> [AmplifyBranch] {
        print("Get Owned Branches success")

        return [fakeAmplifyBranchPrivate, fakeAmplifyBranchOpen1, fakeAmplifyBranchOpen2, fakeAmplifyBranchOpen3]
    }
}

class FakeGetOpenBranchesUseCase: GetOpenBranchesUseCaseProtocol {
    func execute(page: Int) async throws -> [AmplifyBranch] {
        print("Get Open Branches success")
        return [fakeAmplifyBranchOpen1, fakeAmplifyBranchOpen2, fakeAmplifyBranchOpen3]
    }
}

class FakeGetOwnedBranchByIDUseCase: GetOwnedBranchByIDUseCaseProtocol {
    func execute(branchID: String) async throws -> AmplifyBranch {
        print("Get Owned Branch By ID success")

        return fakeAmplifyBranchOpen1
    }
}

class FakeGetOpenBranchByIDUseCase: GetOpenBranchByIDUseCaseProtocol {
    func execute(branchID: String) async throws -> AmplifyBranch {
        print("Get Open Branch By ID success")

        return fakeAmplifyBranchOpen1
    }
}

class FakeGetParticipatedBranchesUseCase: GetParticipatedBranchesUseCaseProtocol {
    func execute() async throws -> [AmplifyBranch] {
        print("Get Participated Branches success")

        return [fakeAmplifyBranchOpen1]
    }
}

class FakeGetNonPrivateBranchesUseCase: GetNonPrivateBranchesUseCaseProtocol {
    func execute(page: Int) async throws -> [AmplifyBranch] {
        return [fakeAmplifyBranchOpen2, fakeAmplifyBranchOpen3]
    }
}

// MARK: - Action

class FakeSaveActionUseCase: SaveActionUseCaseProtocol {
    func execute(branchID:String, actionType:ActionType, content:String?) async throws {
        print("Save Action success")
    }
}

class FakeDeleteActionUseCase: DeleteActionUseCaseProtocol {
    func execute(action: AmplifyAction) async throws {
        print("Delete Action success")
    }
}

class FakeGetCommentsUseCase: GetCommentsUseCaseProtocol {
    func execute(branchID: String) async throws -> [AmplifyAction] {
        return [fakeActionComment1, fakeActionComment2]
    }
}

class FakeGetMessagesUseCase: GetMessagesUseCaseProtocol {
    func execute(branchID: String) async throws -> [AmplifyAction] {
        return [fakeActionMessage1, fakeActionMessage2]
    }
}
