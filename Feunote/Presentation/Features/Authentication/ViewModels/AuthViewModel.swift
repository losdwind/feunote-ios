//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//


import Amplify
import Foundation
import AuthenticationServices
import CryptoKit

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
    
    // For Apple Signin...
    @Published var nonce = ""

    
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
            self.isLoading = false
            Amplify.log.error("\(#function) Error: \(error.localizedDescription)")
            self.error = error as? AppAuthError
        }
        
        
    }
    
    
    func signUp() async {
        startLoading()
        do {
            let nextStep = try await signUpUseCase.execute(username:username, email: email, password: password)
            self.isLoading = false
            self.nextState = nextStep
        } catch(let error){
            self.isLoading = false
            Amplify.log.error("\(#function) Error: \(error.localizedDescription)")
            self.error = error as? AppAuthError
        }

    }
    
    func signIn() async {
        startLoading()
        do {
            let nextStep = try await signInUseCase.execute(username:username, password: password)
            self.isLoading = false
            self.nextState = nextStep
        } catch(let error){
            self.isLoading = false
            Amplify.log.error("\(#function) Error: \(error.localizedDescription)")
            self.error = error as? AppAuthError
        }
    }
    
//    private var window: UIWindow {
//        guard
//            let scene = UIApplication.shared.connectedScenes.first,
//            let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
//            let window = windowSceneDelegate.window as? UIWindow
//        else { return UIWindow() }
//
//        return window
//    }

//    func webSignIn() {
//        _ = Amplify.Auth.signInWithWebUI(presentationAnchor: window,
//                                         options: .preferPrivateSession()) { result in
//            switch result {
//            case .success:
//                self.checkSessionStatus()
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    if case .service(_, _, let underlyingError) = error,
//                       case .userCancelled = (underlyingError as? AWSCognitoAuthError) {
//                        return
//                    } else {
//                        self.authError = error
//                        self.hasError = true
//                    }
//                }
//            }
//        }
//    }

    
    func signOut() async {
        startLoading()
        do {
            let nextStep = try await signOutUserCase.execute()
            self.isLoading = false
            self.nextState = nextStep
        } catch(let error){
            self.isLoading = false
            Amplify.log.error("\(#function) Error: \(error.localizedDescription)")
            self.error = error as? AppAuthError
        }
    }
    

}

extension AuthViewModel {
    func signInWithApple(credential:ASAuthorizationAppleIDCredential) async {
        
    }
    
    func signInWithGoogle() async {
        
    }
    
    
    // Apple Sign In helpler
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }


    @available(iOS 13, *)
    func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }

}
