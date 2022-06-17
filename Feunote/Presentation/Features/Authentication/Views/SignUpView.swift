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
            InputField("Username", text: $authvm.username)

            InputField("Email address", text: $authvm.email)
                .keyboardType(.emailAddress)

            InputField("Password", text: $authvm.password, isSecure: true)

            LoadingButton(title: "Sign up", isLoading: authvm.isLoading, action: authvm.signUp)
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
