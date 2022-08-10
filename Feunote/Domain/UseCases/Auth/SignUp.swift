//
//  SignUp.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/17.
//

import Amplify
import Foundation

class SignUpUseCase: SignUpUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    /// sign into through the authentication service. If first time sign in, it will set up the user model in database.
    func execute(username: String, email: String, password: String) async throws -> AuthStep {
        return try await manager.authRepo.signUp(username: username, email: email, password: password)
    }
}
