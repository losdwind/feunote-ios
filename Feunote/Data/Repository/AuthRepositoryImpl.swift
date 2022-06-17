//
//  AuthRepositoryImpl.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Foundation
import Amplify

class AuthRepositoryImpl:AuthRepositoryProtocol {
    
    private let authService:AuthServiceProtocol
    
    init(authService:AuthServiceProtocol){
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
        
        return try await withCheckedThrowingContinuation({ continuation in
            authService.signIn(username: username, password: password){
                result in
                switch result {
                case .success(_):
                    continuation.resume(returning: AuthStep.done)
                case .failure(_):
                    continuation.resume(throwing: AuthError)
                }
            }
        })
    }
    
    func signUp(username: String, email: String, password: String, completion: @escaping (Result<AuthStep, AuthError>) -> Void) async await -> AuthStep {
        return try await withCheckedThrowingContinuation({ continuation in
            authService.signUp(username: username, email: email, password: password){
                result in
                switch result {
                case .success(_):
                    continuation.resume(returning: AuthStep.confirmSignUp)
                case .failure(_):
                    continuation.resume(throwing: AuthError)
                }
            }
        })
        
    }
    
    func confirmSignUpAndSignIn(username: String, password: String, confirmationCode: String) -> Void) async throws -> AuthStep {
        return try await withCheckedThrowingContinuation({ continuation in
            authService.confirmSignUpAndSignIn(username: username, password: password, confirmationCode: confirmationCode){ result in
                switch result {
                case .success(_):
                    continuation.resume(returning: AuthStep.signIn)
                case .failure(_):
                    continuation.resume(throwing: AuthError)
                }
            }
        })
        
    }
    
    
}
