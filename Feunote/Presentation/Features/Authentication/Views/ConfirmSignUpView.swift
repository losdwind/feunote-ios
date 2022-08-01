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
        VStack(alignment: .center, spacing: .ewPaddingVerticalLarge) {
            Text("We've sent a validation code to your email.\nPlease enter it below.")

            EWTextField(input:  $authvm.confirmationCode , icon: nil, placeholder: "ValidationCode")
                .keyboardType(.numberPad)

            LoadingButtonView(title: "Submit", isLoading: authvm.isLoading){
                Task {
                    await authvm.confirmSignUp()
                }
            }
                .padding(.top, 10)

            if let error = authvm.error {
                Text(error.errorDescription!)
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
        .frame(width:300)
        .padding()

        
    }
}
