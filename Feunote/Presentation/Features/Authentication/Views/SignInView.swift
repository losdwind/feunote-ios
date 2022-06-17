//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject private var authvm: AuthViewModel

    var body: some View {
        AuthContainerView(title: "Login") {
            InputField("Username", text: $authvm.username)

            InputField("Password", text: $authvm.password, isSecure: true)

            LoadingButton(title: "Sign in", isLoading: authvm.isLoading, action: authvm.signIn)
                .padding(.top, 10)

            NavigationLink(destination: ConfirmSignUpView(),
                           when: $authvm.nextState,
                           equals: .confirmSignUp)

            if let error = authvm.error {
                AuthErrorView(error: error)
            }

            Spacer()
            Divider()
            HStack {
                Text("Don't have an account?")
                NavigationLink(destination: SignUpView()) {
                    Text("Sign up").foregroundColor(.orange)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
