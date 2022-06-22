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

    let authRepo: AuthRepositoryProtocol

    @Published var confirmationCode = ""
    @Published var isLoading = false
    @Published var error: AuthError?
    @Published var nextState: AuthStep?

    init(authRepo: AuthRepositoryProtocol = AppRepoManager.shared.authRepo) {
        self.authRepo = authRepo
    }

    func startLoading() {
        nextState = nil
        isLoading = true
        error = nil
    }
    
    func confirmSignUp() async{
        startLoading()
        do {
            let nextStep = try await authRepo.confirmSignUpAndSignIn(username: username, password: password, confirmationCode: confirmationCode)
            try await
            self.isLoading = false
            self.nextState = nextStep
        } catch(let error){
            Amplify.log.error("\(#function) Error: \(error.localizedDescription)")
            self.error = error
        }
        
        
    }
    
    
    func signUp() async {
        startLoading()
        do {
            let nextStep = try await authRepo.signUp(username: username, email: email, password: password)
            self.isLoading = false
            self.nextState = nextStep
        } catch(let error){
            Amplify.log.error("\(#function) Error: \(error.localizedDescription)")
            self.error = error
        }

    }
    
    func signIn() async {
        startLoading()
        do {
            let nextStep = try await authRepo.signIn(username: username, password: password)
            self.isLoading = false
            self.nextState = nextStep
        } catch(let error){
            Amplify.log.error("\(#function) Error: \(error.localizedDescription)")
            self.error = error
        }
    }
}
