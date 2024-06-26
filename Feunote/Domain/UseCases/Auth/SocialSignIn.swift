//
//  SignIn.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/17.
//

import Amplify
import Foundation

class SocialSignInUseCase: SocialSignInUseCaseProtocol {
    private let manager: AppRepositoryManagerProtocol

    init(manager: AppRepositoryManagerProtocol = AppRepoManager.shared) {
        self.manager = manager
    }

    /// sign into through the authentication service. If first time sign in, it will set up the user model in database.
    func execute(socialSignInType: AuthProvider, presentationAnchor: AuthUIPresentationAnchor) async throws -> AuthStep {
        return try await manager.authRepo.socialSignInWithWebUI(socialSignInType: socialSignInType, presentationAnchor: presentationAnchor)
    }
}
