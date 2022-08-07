//
//  FeunoteApp.swift
//  Feunote
//
//  Created by Losd wind on 2022/5/8.
//
import SwiftUI
import Amplify
import Combine
import AWSDataStorePlugin
import AWSAPIPlugin
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin
import AWSLocationGeoPlugin


// MARK: - ViewModel

class FeunoteViewModel: ObservableObject {
    init(authRepo: AuthRepositoryProtocol) {
        self.authRepo = authRepo
        observeState()
    }

    private var authRepo: AuthRepositoryProtocol
    var sessionState: SessionState {
        authRepo.sessionState
    }

    private var subscribers = Set<AnyCancellable>()


    private func observeState() {
        authRepo.sessionStatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &subscribers)
    }
}

// MARK: - View

 @main
struct FeunoteApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject private var authvm = AuthViewModel(signInUseCase: SignInUseCase(), signUpUseCase: SignUpUseCase(), confirmSignUpUseCase: ConfirmSignUpUseCase(), signOutUserCase: SignOutUseCase(), socialSignInUseCase: SocialSignInUseCase())
    @StateObject private var feunotevm = FeunoteViewModel(authRepo: AppRepoManager.shared.authRepo)

    @StateObject var commitvm: CommitViewModel = .init(saveCommitUseCase: SaveCommitUseCase(), deleteCommitUseCase: DeleteCommitUseCase(), getAllCommitsUseCase: GetAllCommitsUseCase(), viewDataMapper: ViewDataMapper())

    @StateObject var branchvm: BranchViewModel = .init(saveBranchUserCase: SaveBranchUseCase(), getOwnedBranchesUseCase: GetOwnedBranchesUseCase(), deleteBranchUseCase: DeleteBranchUseCase(), getProfilesByIDsUserCase: GetProfilesByIDsUseCase(), viewDataMapper: ViewDataMapper())

    @StateObject var profilevm: ProfileViewModel = .init(saveProfileUserCase: SaveProfileUseCase(), getProfileByIDUserCase: GetProfileByIDUseCase(), getCurrentProfileUseCase: GetCurrentProfileUseCase(), deleteProfileUseCase: DeleteProfileUseCase(), viewDataMapper: ViewDataMapper())


    @StateObject var communityvm: CommunityViewModel = .init(saveActionUseCase: SaveActionUseCase(), deleteActionUseCase: DeleteActionUseCase(), getCommentsUseCase: GetCommentsUseCase(), getOpenBranchesUseCase: GetOpenBranchesUseCase(), getOpenBranchByIDUseCase: GetOpenBranchByIDUseCase(), getProfilesByIDsUserCase: GetProfilesByIDsUseCase(), viewDataMapper: ViewDataMapper())

    @StateObject var squadvm: SquadViewModel = .init(saveActionUseCase: SaveActionUseCase(), getMessagesUseCase: GetMessagesUseCase(), getParticipatedBranchesUseCase: GetParticipatedBranchesUseCase(), getProfileByIDUserCase: GetProfileByIDUseCase(), viewDataMapper: ViewDataMapper())
    @StateObject var timelinevm:TimelineViewModel = .init()

    @State var currentUser:AmplifyUser?


    init() {
        configureAmplify()
        AppRepoManager.shared.configure()
        self.currentUser = AppRepoManager.shared.dataStoreRepo.amplifyUser
        let locationManagement = LocationManagement()

    }

    var body: some Scene {
        WindowGroup {
            switch feunotevm.sessionState {
            case .signedIn:
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
            case .signedOut:
                OnBoardingView()
                    .environmentObject(authvm)
            }
        }
    }
}

func configureAmplify() {
    #if DEBUG
    Amplify.Logging.logLevel = .debug
    #endif

    do {
        try Amplify.add(plugin: AWSCognitoAuthPlugin())
        try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels()))
        try Amplify.add(plugin: AWSAPIPlugin())
        try Amplify.add(plugin: AWSS3StoragePlugin())
        try Amplify.add(plugin: AWSLocationGeoPlugin())
        try Amplify.configure()
        Amplify.log.info("Successfully initialized Amplify")
    } catch {
        Amplify.log.error(error: error)
        assert(true, "An error occurred configuring Amplify: \(error)")
    }
}
