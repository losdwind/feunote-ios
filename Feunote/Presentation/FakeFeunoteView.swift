//
//  FakeFeunoteView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/20.
//

import Foundation
import SwiftUI

@main
struct FakeFeunoteApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var authvm = AuthViewModel(signInUseCase: FakeSignInUseCase(), signUpUseCase: FakeSignUpUseCase(), confirmSignUpUseCase: FakeConfirmSignUpUseCase(), signOutUserCase: FakeSignOutUseCase())

    @StateObject var commitvm:CommitViewModel = CommitViewModel(saveCommitUseCase: FakeSaveCommitUseCase(), deleteCommitUseCase: FakeDeleteCommitUseCase(), getAllCommitsUseCase: FakeGetAllCommitsUseCase(), viewDataMapper: FakeViewDataMapper())

    @StateObject var branchvm:BranchViewModel = BranchViewModel(saveBranchUserCase: FakeSaveBranchUseCase(), getAllBranchesUseCase: FakeGetAllBranchesUseCase(), deleteBranchUseCase: FakeDeleteBranchUseCase(), getProfilesByIDsUserCase: FakeGetProfilesByIDsUseCase(), viewDataMapper: FakeViewDataMapper())
    @StateObject var profilevm:ProfileViewModel = ProfileViewModel(saveProfileUserCase: FakeSaveProfileUseCase(), getProfileByIDUserCase: FakeGetProfileByIDUseCase(), getCurrentProfileUseCase: FakeGetCurrentProfileUseCase(), deleteProfileUseCase: FakeDeleteProfileUseCase(), viewDataMapper: FakeViewDataMapper())
    
    @StateObject var communityvm:CommunityViewModel = CommunityViewModel(saveActionUseCase: FakeSaveActionUseCase(), deleteActionUseCase: FakeDeleteActionUseCase(), getCommentsUseCase: FakeGetCommentsUseCase(), getAllBranchesUseCase: FakeGetAllBranchesUseCase(), getBranchByIDUseCase: FakeGetBranchByIDUseCase(), getProfilesByIDsUserCase: FakeGetProfilesByIDsUseCase(), viewDataMapper: FakeViewDataMapper())
    @StateObject var squadvm:SquadViewModel = SquadViewModel()
    
    var body: some Scene {
        WindowGroup {

                ContentView()
                    .environmentObject(commitvm)
                    .environmentObject(branchvm)
                    .environmentObject(profilevm)
                    .environmentObject(authvm)
                    .environmentObject(communityvm)
                    .environmentObject(squadvm)

        }
    }
}
