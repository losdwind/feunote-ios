//
//  AuthError.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/14.
//

import Foundation

// public enum _AuthError {
//
//    /// Caused by issue in the way auth category is configured
//    case configuration(ErrorDescription, RecoverySuggestion, Error? = nil)
//
//    /// Caused by some error in the underlying service. Check the associated error for more details.
//    case service(ErrorDescription, RecoverySuggestion, Error? = nil)
//
//    /// Caused by an unknown reason
//    case unknown(ErrorDescription, Error? = nil)
//
//    /// Caused when one of the input field is invalid
//    case validation(Field, ErrorDescription, RecoverySuggestion, Error? = nil)
//
//    /// Caused when the current session is not authorized to perform an operation
//    case notAuthorized(ErrorDescription, RecoverySuggestion, Error? = nil)
//
//    /// Caused when an operation is not valid with the current state of Auth category
//    case invalidState(ErrorDescription, RecoverySuggestion, Error? = nil)
//
//    /// Caused when an operation needs the user to be in signedIn state
//    case signedOut(ErrorDescription, RecoverySuggestion, Error? = nil)
//
//    /// Caused when a session is expired and needs the user to be re-authenticated
//    case sessionExpired(ErrorDescription, RecoverySuggestion, Error? = nil)
// }

public enum AppAuthError: Error, LocalizedError {
    case invalidInfo
    case SignUpError
    case SignUpConfirmError
    case SignedOutError
    case SignInError
    case sessionExpired
    case serviceDown
    case unknown
    case notAuthorized

    public var errorDescription: String? {
        switch self {
        case .invalidInfo:
            return NSLocalizedString("Invalid Info Error", comment: "Invalid Info Error Occured")
        case .SignUpError:
            return NSLocalizedString("Sign Up Error", comment: "Sign Up Error Occured")

        case .SignUpConfirmError:
            return NSLocalizedString("Sign Up Confirm Error", comment: "Sign Up Confirm Error Occured")

        case .SignedOutError:
            return NSLocalizedString("Signed Out Error", comment: "Signed Out Error Occured")

        case .SignInError:
            return NSLocalizedString("Sign In Error", comment: "Sign In Error Occured")

        case .sessionExpired:
            return NSLocalizedString("Session Expired", comment: "Session Expired")

        case .serviceDown:
            return NSLocalizedString("Service Down", comment: "Service Down")

        case .unknown:
            return NSLocalizedString("Unknown Error", comment: "Unknown Error Occured")

        case .notAuthorized:
            return NSLocalizedString("Not Authorized", comment: "Not Authorized Error")
        }
    }
}
