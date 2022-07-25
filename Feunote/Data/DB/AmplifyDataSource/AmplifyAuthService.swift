//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import Amplify
import SwiftUI
import Combine
import AWSS3StoragePlugin
import AWSCognitoAuthPlugin

protocol AuthServiceProtocol {
    var sessionState: SessionState { get }
    var sessionStatePublisher: Published<SessionState>.Publisher { get }
    var authUser: AuthUser? { get }
    func configure()
    func signIn(username: String, password: String, completion:  @escaping (Result<AuthStep, AuthError>) -> Void)
    func signUp(username: String,
                email: String,
                password: String,
                completion:  @escaping (Result<AuthStep, AuthError>) -> Void)
    func confirmSignUpAndSignIn(username: String,
                                password: String,
                                confirmationCode: String,
                                completion:  @escaping (Result<AuthStep, AuthError>) -> Void)
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
            case .success(let session):
                if let session = session as? AWSAuthCognitoSession {
                    let cognitoTokensResult = session.getCognitoTokens()
                    switch cognitoTokensResult {
                    case .success(let token):
                        print(token.idToken)
                        break
                    case .failure(let error):
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
            case .failure(let error):
                print(error)
                self.authUser = nil
                self.sessionState = .signedOut
            }
        }
    }

    func signIn(username: String, password: String, completion:  @escaping (Result<AuthStep, AuthError>) -> Void) {
        _ = Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            case .success(let result):
                self.updateCurrentUser()
                completion(.success(result.nextStep.authStep))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func signUp(username: String,
                email: String,
                password: String,
                completion:  @escaping (Result<AuthStep, AuthError>) -> Void) {
        let emailAttribute = AuthUserAttribute(.email, value: email)
        let options = AuthSignUpRequest.Options(userAttributes: [emailAttribute])
        _ = Amplify.Auth.signUp(username: username, password: password, options: options) { result in
            switch result {
            case .success(let result):
                completion(.success(result.nextStep.authStep))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func confirmSignUpAndSignIn(username: String,
                                password: String,
                                confirmationCode: String,
                                completion:  @escaping (Result<AuthStep, AuthError>) -> Void) {

        _ = Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case .success(let result):
                if password.isEmpty {
                    completion(.success(.signIn))
                } else if result.isSignupComplete {
                    self.signIn(username: username, password: password, completion: completion)
                } else {
                    completion(.success(.signIn))
                }
            case .failure(let error):
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
            case .failure(let error):
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
