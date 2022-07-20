//
//  FakeUseCase.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/20.
//

import Foundation

// MARK: - Commit

class FakeGetAllCommitsUseCase : GetAllCommitsUseCaseProtocol{
    
    
    func execute(page: Int) async throws -> [AmplifyCommit] {
        
        return [fakeAmplifyMoment1, fakeAmplifyTodo1, fakeAmplifyPerson1]
    }
}


class FakeDeleteCommitUseCase: DeleteCommitUseCaseProtocol{
    
    
    func execute(commitID:String) async throws {
        print("delete success")
    }
    
    
}

class FakeSaveCommitUseCase: SaveCommitUseCaseProtocol{
    
    func execute(commit:AmplifyCommit) async throws{
        print("save success")
    }
    
    
}

// MARK: - Auth

class FakeConfirmSignUpUseCase: ConfirmSignUpUseCaseProtocol{
    func execute(username:String, password:String,confirmationCode:String) async throws -> AuthStep{
        print("confirm Sign Up success")
        return AuthStep.signIn
    }
}


class FakeSignInUseCase: SignInUseCaseProtocol{
    func execute(username:String, password:String) async throws -> AuthStep{
        print("Sign In success")
        return AuthStep.done
    }
}

class FakeSignUpUseCase: SignUpUseCaseProtocol{
    
    func execute(username:String, email:String, password:String) async throws -> AuthStep {
        print("Sign Up success")
        return AuthStep.confirmSignUp
    }
    
}

class FakeSignOutUseCase: SignOutUseCaseProtocol{
    
    func execute() async throws -> AuthStep{
        print("Sign Out success")
        return AuthStep.signIn
    }
    
}

// MARK: - Profile
class FakeDeleteProfileUseCase: DeleteProfileUseCaseProtocol{
    func execute() async throws {
        print("Delete Profile success")
    }
}


class FakeSaveProfileUseCase: SaveProfileUseCaseProtocol{
    
    func execute(user:AmplifyUser) async throws{
        
        print("Save Profile success")
    }
    
}

class FakeGetProfileByIDUseCase : GetProfileByIDUseCaseProtocol{
    
    func execute(userID:String) async throws -> AmplifyUser {
        
        print("Get Profile By ID success")
        return fakeAmplifyUser
        
    }
}

class FakeGetCurrentProfileUseCase : GetCurrentProfileUseCaseProtocol{
    
    func execute() async throws -> AmplifyUser? {
        print("Get Current Profile success")
        return fakeAmplifyUser
    }
}


class FakeGetProfilesByIDsUseCase: GetProfilesByIDsUseCaseProtocol{
    
    
    func execute(userIDs:[String]) async throws -> [AmplifyUser] {
        
        return [fakeAmplifyUser, fakeAmplifyUser]
    }
    
    
}

// MARK: - Branch

class FakeGetAllBranchesUseCase: GetAllBranchesUseCaseProtocol{
    
    func execute(page: Int) async throws -> [AmplifyBranch] {
        print("Get All Branches success")
        
        return [fakeAmplifyBranch, fakeAmplifyBranch]
    }
}



class FakeDeleteBranchUseCase: DeleteBranchUseCaseProtocol{
    
    func execute(branchID:String) async throws {
        print("Delete Branch success")
        
    }
}

class FakeSaveBranchUseCase: SaveBranchUseCaseProtocol{
    
    func execute(branch:AmplifyBranch) async throws{
        print("Save Branch success")
        
        
    }
    
    
    }
