//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) private var presentation
    @EnvironmentObject private var authvm:AuthViewModel

    var body: some View {
        AuthContainerView(title: "Create account") {
            EWTextField(input: $authvm.username, icon: nil, placeholder: "Username")

            EWTextField(input: $authvm.email, icon: nil, placeholder: "Email address")
                .keyboardType(.emailAddress)


            // SecureFiled
            EWTextField(input: $authvm.password, icon: nil, placeholder: "Password")

            LoadingButtonView(title: "Sign up", isLoading: authvm.isLoading){
                Task {
                    try await authvm.signUp()

                }
            }
                .padding(.top, 10)

            NavigationLink(destination: ConfirmSignUpView(),
                           when: $authvm.nextState,
                           equals: .confirmSignUp)

            if let error = authvm.error {
                Text(error.errorDescription!)
            }

            Spacer()
            Divider()
            HStack {
                Text("Already have an account?")
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }, label: {
                    Text("Sign in").foregroundColor(.orange)
                })
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
