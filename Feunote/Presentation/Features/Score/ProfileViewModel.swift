//
//  ScoreViewModel.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/22.
//

import Amplify
import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    internal init(saveProfileUserCase: SaveProfileUseCaseProtocol, getProfileByIDUserCase: GetProfileByIDUseCaseProtocol, getCurrentProfileUseCase: GetCurrentProfileUseCaseProtocol, deleteProfileUseCase: DeleteProfileUseCaseProtocol) {
        self.saveProfileUserCase = saveProfileUserCase
        self.getProfileByIDUserCase = getProfileByIDUserCase
        self.getCurrentProfileUseCase = getCurrentProfileUseCase
        self.deleteProfileUseCase = deleteProfileUseCase
    }

    @Published var fetchedUsers: [AmplifyUser]?
    @Published var currentUser: AmplifyUser?

    // MARK: - here is the issue that the use could be nil becuase the AuthViewModel may not initlize the currentUser correctly (on time)

    @Published var hasError = false
    @Published var appError: Error?

    @Published var settings: FeuSetting = .init(notificationFromGroupMessage: false)

    private var saveProfileUserCase: SaveProfileUseCaseProtocol
    private var getProfileByIDUserCase: GetProfileByIDUseCaseProtocol
    private var getCurrentProfileUseCase: GetCurrentProfileUseCaseProtocol
    private var deleteProfileUseCase: DeleteProfileUseCaseProtocol

    func fetchCurrentUser() async {
            do {
                let user = try await getCurrentProfileUseCase.execute()
                DispatchQueue.main.async {
                    self.currentUser = user
                }
            } catch {
                hasError = true
                appError = error as? Error
            }
    }

//    func fetchUserByID(userID: String) async -> AmplifyUser? {
//        do {
//            try await getProfileByIDUserCase.execute(userID: userID)
//        } catch {
//            hasError = true
//            appError = error as? Error
//        }
//    }

    func connectSocialMedia(source _: SocialMediaCategory, completion _: @escaping (_ success: Bool) -> Void) {}
}
