//
//  FakeFeunoteView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/20.
//
/*
import Foundation
import SwiftUI
//import AWSLocationGeoPlugin
//@main
struct FakeFeunoteApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject private var authvm = AuthViewModel(signInUseCase: FakeSignInUseCase(), signUpUseCase: FakeSignUpUseCase(), confirmSignUpUseCase: FakeConfirmSignUpUseCase(), signOutUserCase: FakeSignOutUseCase(), socialSignInUseCase: FakeSocialSignInUseCase())



    @StateObject var profilevm: ProfileViewModel = .init(saveProfileUserCase: FakeSaveProfileUseCase(), getProfileByIDUserCase: FakeGetProfileByIDUseCase(), getCurrentProfileUseCase: FakeGetCurrentProfileUseCase(), deleteProfileUseCase: FakeDeleteProfileUseCase())

    @StateObject var communityvm: CommunityViewModel = .init(saveActionUseCase: FakeSaveActionUseCase(), deleteActionUseCase: FakeDeleteActionUseCase(), getCommentsUseCase: FakeGetCommentsUseCase(), getOpenBranchesUseCase: FakeGetOpenBranchesUseCase(), getOpenBranchByIDUseCase: FakeGetOpenBranchByIDUseCase(), getProfilesByIDsUserCase: FakeGetProfilesByIDsUseCase())
    @StateObject var squadvm: SquadViewModel = .init(saveActionUseCase: FakeSaveActionUseCase(), getMessagesUseCase: FakeGetMessagesUseCase(), getParticipatedBranchesUseCase: FakeGetParticipatedBranchesUseCase(), getProfileByIDUserCase: FakeGetProfileByIDUseCase())

    @StateObject var timelinevm:TimelineViewModel = .init()
    var body: some Scene {
        WindowGroup {

            ContentView()
                .environmentObject(commitvm)
                .environmentObject(branchvm)
                .environmentObject(profilevm)
                .environmentObject(authvm)
                .environmentObject(communityvm)
                .environmentObject(squadvm)
                .environmentObject(timelinevm)
                .onAppear {
                    Task {
                        await profilevm.fetchCurrentUser()
                    }
                }
        }
    }
}

//@main
struct FakeFeunoteApp2:App {
    @StateObject private var authvm = AuthViewModel(signInUseCase: FakeSignInUseCase(), signUpUseCase: FakeSignUpUseCase(), confirmSignUpUseCase: FakeConfirmSignUpUseCase(), signOutUserCase: FakeSignOutUseCase(), socialSignInUseCase: FakeSocialSignInUseCase())

    @StateObject var profilevm: ProfileViewModel = .init(saveProfileUserCase: FakeSaveProfileUseCase(), getProfileByIDUserCase: FakeGetProfileByIDUseCase(), getCurrentProfileUseCase: FakeGetCurrentProfileUseCase(), deleteProfileUseCase: FakeDeleteProfileUseCase())

    var body:some Scene {
        WindowGroup {
            NavigationView{
                ScoreView()
                    .environmentObject(profilevm)
                    .environmentObject(authvm)
            }

        }
    }
}
*/
