//
//  ProfileViewModel.swift
//  Beliski-Firebase
//
//  Created by Wind Losd on 2021/9/21.
//

import Foundation
import SwiftUI
import Amplify

class ProfileViewModel: ObservableObject{
    internal init(saveProfileUserCase: SaveProfileUseCaseProtocol, getProfileByIDUserCase: GetProfileByIDUseCaseProtocol, getCurrentProfileUseCase: GetCurrentProfileUseCaseProtocol, deleteProfileUseCase: DeleteProfileUseCaseProtocol) {
        self.saveProfileUserCase = saveProfileUserCase
        self.getProfileByIDUserCase = getProfileByIDUserCase
        self.getCurrentProfileUseCase = getCurrentProfileUseCase
        self.deleteProfileUseCase = deleteProfileUseCase
    }
    
    
    @Published var user:FeuUser = FeuUser(email: "", avatarImage: UIImage(), nickName: "")
    @Published var currentUser:FeuUser?
        
    // MARK: - here is the issue that the use could be nil becuase the AuthViewModel may not initlize the currentUser correctly (on time)

    @Published var hasError = false
    @Published var appError:AppError?
    
    private var saveProfileUserCase:SaveProfileUseCaseProtocol
    private var getProfileByIDUserCase:GetProfileByIDUseCaseProtocol
    private var getCurrentProfileUseCase:GetCurrentProfileUseCaseProtocol
    private var deleteProfileUseCase:DeleteProfileUseCaseProtocol
    
    
    
    func saveUser() async{
        do {
            try await saveProfileUserCase.execute(user: user)
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
    }
    

    
    
    func fetchCurrentUser() async{
        
        do {
            currentUser =  try await getCurrentProfileUseCase.execute()
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
        
    }
    
    func fetchUserByID(userID:String) async{
        
        do {
            user = try await getProfileByIDUserCase.execute(userID: userID)
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
        
    }
    
    
    
    func connectSocialMedia(source: SocialMediaCategory, completion: @escaping (_ success: Bool) -> () ){
        
    }
    
    
    
}
