//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import SwiftUI
import Amplify

struct ConfirmSignUpView: View {
    @EnvironmentObject private var authvm: AuthViewModel


    var body: some View {
        AuthContainerView(title: "Validate account") {
            Text("We've sent a validation code to your email.\nPlease enter it below.")

            InputField("Validation code", text: $authvm.confirmationCode)
                .keyboardType(.numberPad)

            LoadingButton(title: "Submit", isLoading: authvm.isLoading, action: authvm.confirmSignUp)
                .padding(.top, 10)

            NavigationLink(destination: SignInView(),
                           when: $authvm.nextState,
                           equals: .signIn)

            if let error = authvm.error {
                AuthErrorView(error: error)
            }

            Spacer()
            if case .notAuthorized = authvm.error {
                Divider()
                NavigationLink(destination: SignInView()) {
                    Text("Go to Login screen").foregroundColor(.orange)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
