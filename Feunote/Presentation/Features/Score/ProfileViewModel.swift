//
//  ProfileViewModel.swift
//  Beliski-Firebase
//
//  Created by Wind Losd on 2021/9/21.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject{
    
    @Published var user:User = User(avatarURL: "", nickName: "")
        
    // MARK: - here is the issue that the use could be nil becuase the AuthViewModel may not initlize the currentUser correctly (on time)
    
    @Published var userPrivate:UserPrivate = UserPrivate(dateCreated: Date(), birthday: Date())
    
    
    func uploadUser(completion: @escaping (_ success: Bool) -> ()){
        
        
    }
    
    
    
    func uploadUserPrivate(completion: @escaping (_ success: Bool) -> ()){
        

        
    }
    
    
    func fetchUserPrivate(completion: @escaping (_ success: Bool) -> ()){

        
    }
    
    
    func fetchCurrentUser(completion: @escaping (_ success: Bool) -> ()){
        

        
    }
    
    
    
    func connectSocialMedia(source: SocialMediaCategory, completion: @escaping (_ success: Bool) -> () ){
        
    }
    
    
}
