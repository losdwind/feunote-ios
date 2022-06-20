//
//  FeunoteApp.swift
//  Feunote
//
//  Created by Losd wind on 2022/5/8.
//

import SwiftUI
import Combine
import Amplify
import AmplifyPlugins

// MARK: - ViewModel
class FeunoteViewModel: ObservableObject {
    var sessionState: SessionState {
        authRepo.sessionState
    }

    private var authRepo: AuthRepositoryProtocol

    private var subscribers = Set<AnyCancellable>()

    init(authRepo:AuthRepositoryProtocol) {
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
@main
struct FeunoteApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var authvm = AuthViewModel()
    @StateObject private var feunotevm = FeunoteViewModel(authRepo: AppRepoManager.shared.authRepo)


    init() {
        configureAmplify()
        AppRepoManager.shared.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            
            switch feunotevm.sessionState {
            case .signedIn:
                ContentView()
            case .signedOut:
                OnBoardingView()
                    .environmentObject(authvm)
            }

        }
    }
}


//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        do {
//            Amplify.Logging.logLevel = .verbose
//            let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
//            try Amplify.add(plugin: dataStorePlugin)
//            try Amplify.add(plugin: AWSCognitoAuthPlugin())
//            try Amplify.add(plugin: AWSS3StoragePlugin())
//            try Amplify.configure()
//            print("Amplify configured with DataStore plugin")
//        } catch {
//            print("Failed to initialize Amplify with \(error)")
//        }
//        return true
//    }
//}

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
