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

    func signIn(username: String, password: String, completion: @escaping (Result<AuthStep, AuthError>) -> Void) {
        authService.signIn(username: username, password: password, completion: completion)
    }
    
    func signUp(username: String, email: String, password: String, completion: @escaping (Result<AuthStep, AuthError>) -> Void) {
        authService.signUp(username: username, email: email, password: password, completion: completion)
    }
    
    func confirmSignUpAndSignIn(username: String, password: String, confirmationCode: String, completion: @escaping (Result<AuthStep, AuthError>) -> Void) {
        authService.confirmSignUpAndSignIn(username: username, password: password, confirmationCode: confirmationCode, completion: completion)
    }
    
    
}