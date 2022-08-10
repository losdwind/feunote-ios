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

    @Published var user: AmplifyUser = .init()
    @Published var fetchedUsers: [AmplifyUser]?
    @Published var currentUser: AmplifyUser?

    // MARK: - here is the issue that the use could be nil becuase the AuthViewModel may not initlize the currentUser correctly (on time)

    @Published var hasError = false
    @Published var appError: AppError?

    @Published var settings: FeuSetting = .init(notificationFromGroupMessage: false)

    private var saveProfileUserCase: SaveProfileUseCaseProtocol
    private var getProfileByIDUserCase: GetProfileByIDUseCaseProtocol
    private var getCurrentProfileUseCase: GetCurrentProfileUseCaseProtocol
    private var deleteProfileUseCase: DeleteProfileUseCaseProtocol

    func saveUser() async {
        do {
            try await saveProfileUserCase.execute(user: user)
        } catch {
            hasError = true
            appError = error as? AppError
        }
    }

    func fetchCurrentUser() async {
        do {
            currentUser = try await getCurrentProfileUseCase.execute()

            if currentUser != nil {
                user = currentUser!
            }
        } catch {
            hasError = true
            appError = error as? AppError
        }
    }

    func fetchUserByID(userID: String) async {
        do {
            user = try await getProfileByIDUserCase.execute(userID: userID)

        } catch {
            hasError = true
            appError = error as? AppError
        }
    }

    func connectSocialMedia(source _: SocialMediaCategory, completion _: @escaping (_ success: Bool) -> Void) {}
}
