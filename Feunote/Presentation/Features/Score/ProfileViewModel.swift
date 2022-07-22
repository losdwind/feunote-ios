//
//  ScoreViewModel.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/22.
//


import Foundation
import SwiftUI
import Amplify

class ProfileViewModel: ObservableObject{
    internal init(saveProfileUserCase: SaveProfileUseCaseProtocol, getProfileByIDUserCase: GetProfileByIDUseCaseProtocol, getCurrentProfileUseCase: GetCurrentProfileUseCaseProtocol, deleteProfileUseCase: DeleteProfileUseCaseProtocol, viewDataMapper: ViewDataMapperProtocol) {
        self.saveProfileUserCase = saveProfileUserCase
        self.getProfileByIDUserCase = getProfileByIDUserCase
        self.getCurrentProfileUseCase = getCurrentProfileUseCase
        self.deleteProfileUseCase = deleteProfileUseCase
        self.viewDataMapper = viewDataMapper
    }
    
    
    @Published var user:FeuUser = FeuUser()
    @Published var fetchedUsers:[FeuUser]?
    @Published var currentUser:FeuUser?
    
    // MARK: - here is the issue that the use could be nil becuase the AuthViewModel may not initlize the currentUser correctly (on time)
    
    @Published var hasError = false
    @Published var appError:AppError?
    
    @Published var settings:FeuSetting = FeuSetting(notificationFromGroupMessage: false)
    
    private var saveProfileUserCase:SaveProfileUseCaseProtocol
    private var getProfileByIDUserCase:GetProfileByIDUseCaseProtocol
    private var getCurrentProfileUseCase:GetCurrentProfileUseCaseProtocol
    private var deleteProfileUseCase:DeleteProfileUseCaseProtocol
    private var viewDataMapper:ViewDataMapperProtocol
    
    
    
    
    func saveUser() async{
        do {
            let amplifyUser = try await viewDataMapper.userDataTransformer(user: self.user)
            try await saveProfileUserCase.execute(user: amplifyUser)
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
    }
    
    
    
    
    func fetchCurrentUser() async{
        
        do {
            guard let currentAmplifyUser =  try await getCurrentProfileUseCase.execute() else {return}
            self.currentUser = try await viewDataMapper.userDataTransformer(user: currentAmplifyUser)
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
        
    }
    
    func fetchUserByID(userID:String) async{
        
        do {
            
            let amplifyUser = try await getProfileByIDUserCase.execute(userID: userID)
            self.user = try await viewDataMapper.userDataTransformer(user: amplifyUser)
            
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
        
    }
    

    
    
    
    func connectSocialMedia(source: SocialMediaCategory, completion: @escaping (_ success: Bool) -> () ){
        
    }
    
    
    
}
