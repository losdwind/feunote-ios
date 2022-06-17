//
//  AuthErrorView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Amplify
import SwiftUI

struct AuthErrorView: View {
    let error: AuthError

    var body: some View {
        Text("\(error.errorDescription)\n\n\(error.recoverySuggestion)")
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.red)
    }
}

struct AuthErrorView_Previews:PreviewProvider{
    static var previews:some View {
        AuthErrorView(error: AuthError.notAuthorized("not authorized", "Try Again Later", nil))
    }
}
