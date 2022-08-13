//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import Amplify
import SwiftUI
// public enum FeunoteError: Error {
//    case model(ErrorDescription, RecoverySuggestion, Error? = nil)
// }
//
// extension FeunoteError: AmplifyError {
//
//    public var errorDescription: ErrorDescription {
//        switch self {
//        case .model(let errorDescription, _, _):
//            return errorDescription
//        }
//    }
//
//    public var recoverySuggestion: RecoverySuggestion {
//        switch self {
//        case .model(_, let recoverySuggestion, _):
//            return recoverySuggestion
//        }
//    }
//
//    public var underlyingError: Error? {
//        switch self {
//        case .model(_, _, let underlyingError):
//            return underlyingError
//        }
//    }
//
//    public init(errorDescription: ErrorDescription = "An unknown error occurred",
//                recoverySuggestion: RecoverySuggestion = "See `underlyingError` for more details",
//                error: Error) {
//        self = .model(errorDescription, recoverySuggestion, error)
//    }
// }

public enum AppError: Error, LocalizedError {
    case failedToParseData
    case failedToSave
    case failedToRead
    case failedToDelete
    case failedToSignIn
    case failedToSignUp
    case failedToConnect
    case failedToLoadResource
    case failedToSaveResource
    case failedToDeleteResource
    case invalidSubmit
    case invalidLoginStatus
    case itemDoNotExist
    case itemCannotBeFlattened

    public var errorDescription: String? {
        switch self {
        case .failedToParseData:
            return NSLocalizedString("Oops! Cannot understand the data from database, try update your application to the latest version. ", comment: "This is the error message shown to user when application failed to parse the data given by the database of the backend service")
        case .failedToSave:
            return NSLocalizedString("Oops! Cannot Save the data to database, try logout and login again ", comment: "This is the error message shown to user when application failed to save the data to the database of the backend service")
        case .failedToRead:
            return NSLocalizedString("Oops! Cannot Read the data to database, try again later ", comment: "This is the error message shown to user when application failed to read the data from the database of the backend service")
        case .failedToDelete:
            return NSLocalizedString("Oops! Cannot delete the data in database, try again later ", comment: "This is the error message shown to user when application failed to delete the data in the database of the backend service")
        case .failedToSignIn:
            return NSLocalizedString("Oops! Cannot Sign in your account.", comment: "This is the error message shown to user when application cannot sign in the account")
        case .failedToSignUp:
            return NSLocalizedString("Oops! Cannot Sign up your account.", comment: "This is the error message shown to user when application cannot sign up the account")
        case .failedToConnect:
            return NSLocalizedString("Oops! Cannot connect to the server. Please try it later", comment: "This is the error message shown to user when application cannot connect to the cloud server")
        case .failedToLoadResource:
            return NSLocalizedString("Oops! Cannot load files", comment: "This is the error message shown to user when application cannot load rich media resource from database, like images, videos, audios, files")
        case .failedToSaveResource:
            return NSLocalizedString("Oops! Cannot save files", comment: "This is the error message shown to user when application cannot save rich media resource to database, like images, videos, audios, files")
        case .failedToDeleteResource:
            return NSLocalizedString("Oops! Cannot delete files", comment: "This is the error message shown to user when application cannot delete related rich media resource from database when delete the commit, like images, videos, audios, files")
        case .invalidSubmit:
            return NSLocalizedString("The submited content is invalid", comment: "This is the error message shown to user when user submitted empty or invalid contents")
        case .invalidLoginStatus:
            return NSLocalizedString("Log In Status Invalid", comment: "This is the error message shown to user when user's login state is invalid")
            case .itemDoNotExist:
                return NSLocalizedString("Queried item do not exist", comment: "This is the error message shown to user when user queried an item which is not in the database")
            case .itemCannotBeFlattened:
                return NSLocalizedString("resource cannot be flattened before upload to S3", comment: "This is the error message shown to user when user want to upload a resource but the resource cannot be compressed before uploading")
        }
    }
}
