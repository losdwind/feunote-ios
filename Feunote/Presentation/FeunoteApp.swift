//
//  FeunoteApp.swift
//  Feunote
//
//  Created by Losd wind on 2022/5/8.
//
import Amplify
import AWSAPIPlugin
import AWSCognitoAuthPlugin
import AWSDataStorePlugin
import AWSLocationGeoPlugin
import AWSS3StoragePlugin
import Combine
import SwiftUI
import PartialSheet

// MARK: - ViewModel
@MainActor
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

    @StateObject var profilevm: ProfileViewModel = .init(saveProfileUserCase: SaveProfileUseCase(), getProfileByIDUserCase: GetProfileByIDUseCase(), getCurrentProfileUseCase: GetCurrentProfileUseCase(), deleteProfileUseCase: DeleteProfileUseCase())

    @StateObject var communityvm: CommunityViewModel = CommunityViewModel()

    @StateObject var squadvm: SquadViewModel = .init(getMessagesUseCase: GetMessagesUseCase(), getParticipatedBranchesUseCase: GetParticipatedBranchesUseCase())

    @StateObject var timelinevm: TimelineViewModel = TimelineViewModel()
    @StateObject var mapvm: AppleMapViewModel = AppleMapViewModel()

    init() {
            configureAmplify()
            AppRepoManager.shared.configure()
    }
    

    var body: some Scene {
        WindowGroup {
            switch feunotevm.sessionState {
            case .signedIn:
                ContentView()
                    .attachPartialSheetToRoot()
                    .environmentObject(profilevm)
                    .environmentObject(authvm)
                    .environmentObject(communityvm)
                    .environmentObject(squadvm)
                    .environmentObject(timelinevm)
                    .environmentObject(mapvm)
                    .task {
                        await profilevm.fetchCurrentUser()
//                        await timelinevm.getAllCommits(page: 0)
//                        await timelinevm.getAllBranchs(page: 0)
//                        await communityvm.getOpenBranches(page: 0)
//                        await communityvm.getSubscribedBranches(page: 0)
//                        await squadvm.getParticipatedBranches()
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
    Amplify.Logging.logLevel = .error
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
