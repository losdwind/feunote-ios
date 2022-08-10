//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import AuthenticationServices
import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) private var presentation
    @EnvironmentObject private var authvm: AuthViewModel

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(alignment: .center, spacing: .ewPaddingVerticalLarge) {
            HStack {
                Text("Create \nAccount.").font(Font.ewLargeTitle).foregroundColor(.ewBlack)
                    .fontWeight(.bold)
                    .frame(alignment: .leading)
                Spacer()
            }
            .padding(.ewPaddingVerticalLarge)

            VStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
                EWTextField(input: $authvm.username, icon: nil, placeholder: "Username")

                EWTextField(input: $authvm.email, icon: nil, placeholder: "Email address")
                    .keyboardType(.emailAddress)

                // SecureFiled
                EWSecureTextField(input: $authvm.password, icon: nil, placeholder: "Password")
            }

            TermsAndConditonString()

            if let error = authvm.error {
                Text(error.errorDescription!).foregroundColor(.ewError).font(Font.ewFootnote)
            }

            LoadingButtonView(title: "Sign up", isLoading: authvm.isLoading) {
                Task {
                    await authvm.signUp()
                }
            }

            NavigationLink(destination: ConfirmSignUpView(),
                           when: $authvm.nextState,
                           equals: .confirmSignUp)

            // OR
            HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall) {
                VStack {
                    Divider()
                }
                Text("OR")
                    .font(.ewFootnote)
                    .foregroundColor(.ewGray900)
                VStack {
                    Divider()
                }
            }

//            VStack(alignment: .center, spacing: .ewPaddingHorizontalSmall) {
//                // Apple Sign In...
//                // See my Apple Sign in Video for more depth....
//                SignInWithAppleButton(onRequest: { request in
//
//                    // requesting paramertes from apple login...
//                    authvm.nonce = authvm.randomNonceString()
//                    request.requestedScopes = [.email,.fullName]
//                    request.nonce = authvm.sha256(authvm.nonce)
//
//                }, onCompletion: { result in
//
//                    // getting error or success...
//
//                    switch result{
//                    case .success(let user):
//                        print("success")
//                        // do Login With Firebase...
//                        guard let credential = user.credential as? ASAuthorizationAppleIDCredential else{
//                            print("error with firebase")
//                            return
//                        }
//                        Task {
//                            await authvm.signInWithApple(credential: credential)
//                        }
//
//                    case.failure(let error):
//                        print(error.localizedDescription)
//                    }
//
//                })
//                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
//                    .frame(width:300,height:40)
//
//                // Google Sign In
//                Button {
//                    Task {
//                        await authvm.signInWithGoogle()
//                    }
//                } label: {
//
//                    HStack(spacing: 5){
//
//                        Image("Google")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 18, height: 18)
//
//                        Text("Sign In with Google")
//                            .font(.subheadline)
//                            .fontWeight(.medium)
//                            .foregroundColor(Color.init(hexString: "000000"))
//
//                    }
//                    .frame(width:300,height:40)
//                    .background(Color.init(hexString: "EEEEEE"), in: RoundedRectangle(cornerRadius: 8))
//
//                }
//            }

            Spacer()

            HStack {
                Text("Already have an account?")
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }, label: {
                    Text("Sign in").foregroundColor(.ewSecondary700)
                })
            }
        }
        .frame(width: 300)
        .padding()
    }
}
