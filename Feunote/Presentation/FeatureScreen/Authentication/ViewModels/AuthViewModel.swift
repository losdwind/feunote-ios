//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//


import Amplify
import Foundation

class AuthViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""

    let authRepo: AuthServiceProtocol

    @Published var confirmationCode = ""
    @Published var isLoading = false
    @Published var error: AuthError?
    @Published var nextState: AuthStep?

    init(manager: AppRepositoryManagerProtocol = AppRepositoryManager.shared) {
        self.authRepo = manager.authRepo
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
    
    
    func confirmSignUp() {
        startLoading()
        authRepo.confirmSignUpAndSignIn(username: username,
                                           password: password,
                                           confirmationCode: confirmationCode,
                                           completion: authCompletionHandler)
    }
    
    
    func signUp() {
        startLoading()
        authRepo.signUp(username: username,
                           email: email,
                           password: password,
                           completion: authCompletionHandler)
    }
    
    func signIn() {
        startLoading()
        authRepo.signIn(username: username,
                                password: password,
                                completion: authCompletionHandler)
    }
}
