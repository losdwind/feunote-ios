//
//  AuthRepository.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Foundation
import Amplify
protocol AuthRepositoryProtocol {
    
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
}
