//
//  FeunoteApp.swift
//  Feunote
//
//  Created by Losd wind on 2022/5/8.
//

import SwiftUI
import Amplify
import AmplifyPlugins

@main
struct FeunoteApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @ObservedObject private var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            
            switch viewModel.sessionState {
            case .signedIn:
                UserProfileView()
//                ContentView()
                //TestView()
            case .signedOut:
                OnBoardingView()
            }

        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        do {
            Amplify.Logging.logLevel = .verbose
            let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            try Amplify.configure()
            print("Amplify configured with DataStore plugin")
        } catch {
            print("Failed to initialize Amplify with \(error)")
        }
        return true
    }
}
