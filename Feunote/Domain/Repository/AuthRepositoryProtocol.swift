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
        
    func signIn(username: String, password: String) async throws -> AuthStep
    
    func signUp(username: String, email: String, password: String) async throws -> AuthStep
    
    func confirmSignUpAndSignIn(username: String, password: String, confirmationCode: String) async throws -> AuthStep
    
    func signOut() async throws
}
