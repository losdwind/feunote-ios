//
//  AuthRepositoryImpl.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Amplify
import Foundation

class AuthRepositoryImpl: AuthRepositoryProtocol {
    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    var sessionState: SessionState {
        authService.sessionState
    }

    var sessionStatePublisher: Published<SessionState>.Publisher {
        authService.sessionStatePublisher
    }

    var authUser: AuthUser? {
        authService.authUser
    }

    func configure() {
        authService.configure()
    }

    func signIn(username: String, password: String) async throws -> AuthStep {
        print("signin activated")

        return try await withCheckedThrowingContinuation { continuation in
            authService.signIn(username: username, password: password) {
                result in
                switch result {
                case let .success(step):
                    continuation.resume(returning: step)
                case let .failure(error):
                    print(error)
                    continuation.resume(throwing: AppAuthError.SignInError)
                }
            }
        }
    }

    func socialSignInWithWebUI(socialSignInType: AuthProvider, presentationAnchor: AuthUIPresentationAnchor) async throws -> AuthStep {
        print("social signin activated")
        return try await withCheckedThrowingContinuation { continuation in
            authService.socialSignInWithWebUI(socialSignInType: socialSignInType, presentationAnchor: presentationAnchor) {
                result in
                switch result {
                case let .success(step):
                    continuation.resume(returning: step)
                case let .failure(error):
                    print(error)
                    continuation.resume(throwing: AppAuthError.SignInError)
                }
            }
        }
    }

    func signUp(username: String, email: String, password: String) async throws -> AuthStep {
        print("sign up activated")
        return try await withCheckedThrowingContinuation { continuation in
            authService.signUp(username: username, email: email, password: password) {
                result in
                switch result {
                case let .success(step):
                    continuation.resume(returning: step)
                case let .failure(error):
                    print(error)
                    continuation.resume(throwing: AppAuthError.SignUpError)
                }
            }
        }
    }

    func confirmSignUpAndSignIn(username: String, password: String, confirmationCode: String) async throws -> AuthStep {
        print("confirm sign up activated")

        return try await withCheckedThrowingContinuation { continuation in
            authService.confirmSignUpAndSignIn(username: username, password: password, confirmationCode: confirmationCode) { result in
                switch result {
                case let .success(step):
                    continuation.resume(returning: step)
                case let .failure(error):
                    print(error)
                    continuation.resume(throwing: AppAuthError.SignUpConfirmError)
                }
            }
        }
    }

    func signOut() async throws -> AuthStep {
        print("sign out activated")

        return try await withCheckedThrowingContinuation { continuation in
            authService.signOut {
                result in
                switch result {
                case .success():
                    continuation.resume(returning: AuthStep.signIn)
                case let .failure(error):
                    print(error)
                    continuation.resume(throwing: AppAuthError.SignedOutError)
                }
            }
        }
    }
}
