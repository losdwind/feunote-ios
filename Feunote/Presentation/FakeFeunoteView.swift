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

    @StateObject var commitvm: CommitViewModel = .init(saveCommitUseCase: FakeSaveCommitUseCase(), deleteCommitUseCase: FakeDeleteCommitUseCase(), getAllCommitsUseCase: FakeGetAllCommitsUseCase(), viewDataMapper: FakeViewDataMapper())

    @StateObject var branchvm: BranchViewModel = .init(saveBranchUserCase: FakeSaveBranchUseCase(), getOwnedBranchesUseCase: FakeGetOwnedBranchesUseCase(), deleteBranchUseCase: FakeDeleteBranchUseCase(), getProfilesByIDsUserCase: FakeGetProfilesByIDsUseCase(), viewDataMapper: FakeViewDataMapper())
    @StateObject var profilevm: ProfileViewModel = .init(saveProfileUserCase: FakeSaveProfileUseCase(), getProfileByIDUserCase: FakeGetProfileByIDUseCase(), getCurrentProfileUseCase: FakeGetCurrentProfileUseCase(), deleteProfileUseCase: FakeDeleteProfileUseCase(), viewDataMapper: FakeViewDataMapper())

    @StateObject var communityvm: CommunityViewModel = .init(saveActionUseCase: FakeSaveActionUseCase(), deleteActionUseCase: FakeDeleteActionUseCase(), getCommentsUseCase: FakeGetCommentsUseCase(), getOpenBranchesUseCase: FakeGetOpenBranchesUseCase(), getOpenBranchByIDUseCase: FakeGetOpenBranchByIDUseCase(), getProfilesByIDsUserCase: FakeGetProfilesByIDsUseCase(), viewDataMapper: FakeViewDataMapper())
    @StateObject var squadvm: SquadViewModel = .init(saveActionUseCase: FakeSaveActionUseCase(), getMessagesUseCase: FakeGetMessagesUseCase(), getParticipatedBranchesUseCase: FakeGetParticipatedBranchesUseCase(), getProfileByIDUserCase: FakeGetProfileByIDUseCase(), viewDataMapper: FakeViewDataMapper())

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
