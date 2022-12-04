//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import Amplify
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin
import Combine
import SwiftUI
import UIKit
import AWSPluginsCore

protocol AuthServiceProtocol {
    var sessionState: SessionState { get }
    var sessionStatePublisher: Published<SessionState>.Publisher { get }
    var authUser: AuthUser? { get }
    func configure()
    func signIn(username: String, password: String, completion: @escaping (Result<AuthStep, AuthError>) -> Void)
    func socialSignInWithWebUI(socialSignInType: AuthProvider, presentationAnchor: AuthUIPresentationAnchor, completion: @escaping (Result<AuthStep, AuthError>) -> Void)
    func signUp(username: String,
                email: String,
                password: String,
                completion: @escaping (Result<AuthStep, AuthError>) -> Void)
    func confirmSignUpAndSignIn(username: String,
                                password: String,
                                confirmationCode: String,
                                completion: @escaping (Result<AuthStep, AuthError>) -> Void)
    func signOut(completion: @escaping (Result<Void, AuthError>) -> Void)
}

class AmplifyAuthService: AuthServiceProtocol {
    @Published private(set) var sessionState: SessionState = .signedOut
    var sessionStatePublisher: Published<SessionState>.Publisher { $sessionState }
    var authUser: AuthUser?

    var subscribers = Set<AnyCancellable>()

    init() {}

    func configure() {
        fetchAuthSession()
    }

    private func fetchAuthSession() {
        Amplify.Auth.fetchAuthSession { result in
            switch result {
            case let .success(session):
                if let session = session as? AWSAuthCognitoSession {
                    let cognitoTokensResult = session.getCognitoTokens()
                    switch cognitoTokensResult {
                    case let .success(token):
                        print(token.idToken)
                    case let .failure(error):
                        print(error)
                        self.authUser = nil
                        self.sessionState = .signedOut
                        self.observeAuthEvents()
                        Amplify.log.error("\(error.localizedDescription)")
                        return
                    }

                }

                self.updateCurrentUser()
                self.observeAuthEvents()
            case let .failure(error):
                print(error)
                self.authUser = nil
                self.sessionState = .signedOut
            }
        }
    }

    func signIn(username: String, password: String, completion: @escaping (Result<AuthStep, AuthError>) -> Void) {
        _ = Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            case let .success(result):
                self.updateCurrentUser()
                completion(.success(result.nextStep.authStep))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private var window: UIWindow {
        guard
            let scene = UIApplication.shared.connectedScenes.first,
            let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
            let window = windowSceneDelegate.window as? UIWindow
        else { return UIWindow() }

        return window
    }

    func socialSignInWithWebUI(socialSignInType: AuthProvider, presentationAnchor: AuthUIPresentationAnchor, completion: @escaping (Result<AuthStep, AuthError>) -> Void) {
        Amplify.Auth.signInWithWebUI(for: socialSignInType, presentationAnchor: presentationAnchor, options: .preferPrivateSession()) { result in
            switch result {
            case let .success(result):
                print("Sign in with \(socialSignInType) succeeded")
                self.updateCurrentUser()
                completion(.success(result.nextStep.authStep))
            case let .failure(error):
                print("Sign in failed \(error)")
                completion(.failure(error))
            }
        }
    }

    func signUp(username: String,
                email: String,
                password: String,
                completion: @escaping (Result<AuthStep, AuthError>) -> Void)
    {
        let emailAttribute = AuthUserAttribute(.email, value: email)
        let options = AuthSignUpRequest.Options(userAttributes: [emailAttribute])
        _ = Amplify.Auth.signUp(username: username, password: password, options: options) { result in
            switch result {
            case let .success(result):
                completion(.success(result.nextStep.authStep))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func confirmSignUpAndSignIn(username: String,
                                password: String,
                                confirmationCode: String,
                                completion: @escaping (Result<AuthStep, AuthError>) -> Void)
    {
        _ = Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case let .success(result):
                if password.isEmpty {
                    completion(.success(.signIn))
                } else if result.isSignupComplete {
                    self.signIn(username: username, password: password, completion: completion)
                } else {
                    completion(.success(.signIn))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func signOut(completion: @escaping (Result<Void, AuthError>) -> Void) {
        _ = Amplify.Auth.signOut { result in
            switch result {
            case .success:
                self.authUser = nil
                self.sessionState = .signedOut
                completion(.successfulVoid)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func observeAuthEvents() {
        Amplify.Hub.publisher(for: .auth)
            .sink { payload in
                switch payload.eventName {
                case HubPayload.EventName.Auth.sessionExpired:
                    self.fetchAuthSession()
                default:
                    break
                }
            }
            .store(in: &subscribers)
    }

    private func updateCurrentUser() {
        guard let user = Amplify.Auth.getCurrentUser() else {
            authUser = nil
            sessionState = .signedOut
            return
        }
        authUser = user
        sessionState = .signedIn(user)
    }
}
