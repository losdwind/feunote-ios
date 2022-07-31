//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import SwiftUI
import AuthenticationServices
import Amplify

struct SignInView: View {
    @EnvironmentObject private var authvm: AuthViewModel
    @Environment(\.colorScheme) var colorScheme


    var body: some View {

        VStack(alignment: .center, spacing: .ewPaddingVerticalLarge){
            
            HStack(){
                Text("Welcome \nBack.").font(Font.ewLargeTitle).foregroundColor(.ewBlack)
                    .fontWeight(.bold)
                    .frame(alignment: .leading)
                Spacer()
            }
            .padding(.ewPaddingVerticalLarge)
               
            VStack(alignment: .center, spacing: .ewPaddingHorizontalDefault){
                
                EWTextField(input: $authvm.username, icon: Image("user"), placeholder: "Username")

                // SecureFiled
                EWSecureTextField(input: $authvm.password, icon: Image("lock"), placeholder: "Password")

            }
            
            TermsAndConditonString()
                
            
            if let error = authvm.error {
                Text(error.errorDescription!).foregroundColor(.ewError).font(Font.ewFootnote)
            }

            
            
            LoadingButtonView(title: "Sign in", isLoading: authvm.isLoading){
                Task {
                    await authvm.signIn()
                }
            }


            

            NavigationLink(destination: ConfirmSignUpView(),
                           when: $authvm.nextState,
                           equals: .confirmSignUp)

            
            // OR
            HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall) {
                VStack{
                    Divider()
                }
                Text("OR")
                    .font(.ewFootnote)
                    .foregroundColor(.ewGray900)
                VStack{
                    Divider()
                }
            }
            
            VStack(alignment: .center, spacing: .ewPaddingHorizontalSmall) {
                // Apple Sign In...
                // See my Apple Sign in Video for more depth....


                /*
                SignInWithAppleButton(onRequest: { request in
                    
                    // requesting paramertes from apple login...
                    authvm.nonce = authvm.randomNonceString()
                    request.requestedScopes = [.email,.fullName]
                    request.nonce = authvm.sha256(authvm.nonce)
                    
                }) { result in
                    
                    // getting error or success...
                    
                    switch result{
                    case .success(let user):
                        print("success")
                        // do Login With Firebase...
                        guard let credential = user.credential as? ASAuthorizationAppleIDCredential else{
                            print("error with firebase")
                            return
                        }
                        Task {
                            await authvm.signInWithApple(credential: credential)
                        }
                        
                    case.failure(let error):
                        print(error.localizedDescription)
                    }
                    
                }
                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                    .frame(width:300,height:40)

                 */

                SignInWithAppleButton(SignInWithAppleButton.Label.continue, onRequest: { _ in
                    Task {
                        await authvm.socialSignIn(socialSingInType: .apple)

                    }
                }, onCompletion: {_ in })
                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                .frame(width:300,height:40)

                // Google Sign In
                Button {
                    Task {
                        await authvm.socialSignIn(socialSingInType:.google)
                    }
                } label: {
                    
                    HStack(spacing: 5){
                        
                        Image("Google")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                        
                        Text("Continue with Google")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.init(hexString: "000000"))

                    }
                    .frame(width:300,height:40)
                    .background(Color.init(hexString: "EEEEEE"), in: RoundedRectangle(cornerRadius: 8))

                }
            }
            
        

            
            Spacer()
            
            HStack(alignment: .center, spacing:.ewPaddingHorizontalSmall){
                Text("Don't have an account?")
                NavigationLink(destination: SignUpView()) {
                    Text("Sign up").foregroundColor(.ewSecondary700)
                }
            }
        }
        .frame(width:300)
        .padding()

        
    }
}


struct SignInView_Previews:PreviewProvider {
    
    static private var authvm:AuthViewModel = AuthViewModel(signInUseCase: FakeSignInUseCase(), signUpUseCase: SignUpUseCase(), confirmSignUpUseCase: ConfirmSignUpUseCase(), signOutUserCase: SignOutUseCase(), socialSignInUseCase: SocialSignInUseCase())
    
    static var previews: some View {
        SignInView()
            .environmentObject(authvm)
    }
    
}


struct TermsAndConditonString:View {
    var body: some View {
        (
          Text("By create an account, you agree to our")
            .font(.system(size: 12))
            .foregroundColor(Color(red: 0.28, green: 0.33, blue: 0.41))
        +
          Text(" Terms & Conditions ")
            .font(.system(size: 12))
            .foregroundColor(Color(red: 0.28, green: 0.52, blue: 0.69))
        +
          Text("and")
            .font(.system(size: 12))
            .foregroundColor(Color(red: 0.28, green: 0.33, blue: 0.41))
        +
          Text(" Privacy Policy")
            .font(.system(size: 12))
            .foregroundColor(Color(red: 0.28, green: 0.52, blue: 0.69))
        )
            .fixedSize(horizontal: false, vertical: true)
    }

}
