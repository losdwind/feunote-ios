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
