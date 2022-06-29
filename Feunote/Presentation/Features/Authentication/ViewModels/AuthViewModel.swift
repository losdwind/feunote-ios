//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//


import Amplify
import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    internal init(signInUseCase: SignInUseCaseProtocol, signUpUseCase: SignUpUseCaseProtocol, confirmSignUpUseCase: ConfirmSignUpUseCaseProtocol, signOutUserCase: SignOutUseCaseProtocol) {
        self.signInUseCase = signInUseCase
        self.signUpUseCase = signUpUseCase
        self.confirmSignUpUseCase = confirmSignUpUseCase
        self.signOutUserCase = signOutUserCase
    }
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""

    @Published var confirmationCode = ""
    @Published var isLoading = false
    @Published var error: AppAuthError?
    @Published var nextState: AuthStep?

    
    private var signInUseCase:SignInUseCaseProtocol
    private var signUpUseCase:SignUpUseCaseProtocol
    private var confirmSignUpUseCase:ConfirmSignUpUseCaseProtocol
    private var signOutUserCase:SignOutUseCaseProtocol

    func startLoading() {
        nextState = nil
        isLoading = true
        error = nil
    }
    
    func confirmSignUp() async{
        startLoading()
        do {
            let nextStep = try await confirmSignUpUseCase.execute(username: username, password: password, confirmationCode: confirmationCode)
            self.isLoading = false
            self.nextState = nextStep
        } catch(let error){
            Amplify.log.error("\(#function) Error: \(error.localizedDescription)")
            self.error = error as? AppAuthError
        }
        
        
    }
    
    
    func signUp() async {
        startLoading()
        do {
            let nextStep = try await signUpUseCase.execute(username: username, password: password)
            self.isLoading = false
            self.nextState = nextStep
        } catch(let error){
            Amplify.log.error("\(#function) Error: \(error.localizedDescription)")
            self.error = error as? AppAuthError
        }

    }
    
    func signIn() async {
        startLoading()
        do {
            let nextStep = try await signInUseCase.execute(username: username, password: password)
            self.isLoading = false
            self.nextState = nextStep
        } catch(let error){
            Amplify.log.error("\(#function) Error: \(error.localizedDescription)")
            self.error = error as? AppAuthError
        }
    }
    
    func signOut() async {
        startLoading()
        do {
            let nextStep = try await signOutUserCase.execute()
            self.isLoading = false
            self.nextState = nextStep
        } catch(let error){
            Amplify.log.error("\(#function) Error: \(error.localizedDescription)")
            self.error = error as? AppAuthError
        }
    }
}
