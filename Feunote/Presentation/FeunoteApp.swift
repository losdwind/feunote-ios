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


// MARK: - ViewModel

class FeunoteViewModel: ObservableObject {
    var sessionState: SessionState {
        authRepo.sessionState
    }

    private var authRepo: AuthRepositoryProtocol

    private var subscribers = Set<AnyCancellable>()

    init(authRepo: AuthRepositoryProtocol) {
        self.authRepo = authRepo
        observeState()
    }

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

// @main
struct FeunoteApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject private var authvm = AuthViewModel(signInUseCase: SignInUseCase(), signUpUseCase: SignUpUseCase(), confirmSignUpUseCase: ConfirmSignUpUseCase(), signOutUserCase: SignOutUseCase())
    @StateObject private var feunotevm = FeunoteViewModel(authRepo: AppRepoManager.shared.authRepo)

    @StateObject var commitvm: CommitViewModel = .init(saveCommitUseCase: SaveCommitUseCase(), deleteCommitUseCase: DeleteCommitUseCase(), getAllCommitsUseCase: GetAllCommitsUseCase(), viewDataMapper: ViewDataMapper())

    @StateObject var branchvm: BranchViewModel = .init(saveBranchUserCase: SaveBranchUseCase(), getOwnedBranchesUseCase: GetOwnedBranchesUseCase(), deleteBranchUseCase: DeleteBranchUseCase(), getProfilesByIDsUserCase: GetProfilesByIDsUseCase(), viewDataMapper: ViewDataMapper())

    @StateObject var profilevm: ProfileViewModel = .init(saveProfileUserCase: SaveProfileUseCase(), getProfileByIDUserCase: GetProfileByIDUseCase(), getCurrentProfileUseCase: GetCurrentProfileUseCase(), deleteProfileUseCase: DeleteProfileUseCase(), viewDataMapper: ViewDataMapper())

    init() {
        configureAmplify()
        AppRepoManager.shared.configure()
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
        try Amplify.configure()
        Amplify.log.info("Successfully initialized Amplify")
    } catch {
        Amplify.log.error(error: error)
        assert(true, "An error occurred configuring Amplify: \(error)")
    }
}
