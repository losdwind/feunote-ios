//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import Amplify
import Foundation
import SwiftUI

extension SignInView {

    class ViewModel: AuthViewModel {
        func signIn() {
            startLoading()
            authService.signIn(username: user.username,
                                    password: user.password,
                                    completion: authCompletionHandler)
        }
    }
}

extension SignUpView {

    class ViewModel: AuthViewModel {
        func signUp() {
            startLoading()
            authService.signUp(username: user.username,
                               email: user.email,
                               password: user.password,
                               completion: authCompletionHandler)
        }
    }
}

extension ConfirmSignUpView {

    class ViewModel: AuthViewModel {
        func confirmSignUp() {
            startLoading()
            authService.confirmSignUpAndSignIn(username: user.username,
                                               password: user.password,
                                               confirmationCode: confirmationCode,
                                               completion: authCompletionHandler)
        }
    }
}

class AuthViewModel: ObservableObject {
    class User: ObservableObject {
        @Published var username = ""
        @Published var email = ""
        @Published var password = ""
    }

    let authService: AuthServiceProtocol

    @Published var user = User()
    @Published var confirmationCode = ""
    @Published var isLoading = false
    @Published var error: AuthError?
    @Published var nextState: AuthStep?

    init(manager: AppServiceManagerProtocol = AppServiceManager.shared) {
        self.authService = manager.authService
    }

    func startLoading() {
        nextState = nil
        isLoading = true
        error = nil
    }

    func authCompletionHandler(_ result: Result<AuthStep, AuthError>) {
        DispatchQueue.main.async {
            self.isLoading = false
            switch result {
            case .success(let nextStep):
                self.nextState = nextStep
            case .failure(let error):
                Amplify.log.error("\(#function) Error: \(error.localizedDescription)")
                self.error = error
            }
        }
    }
}
