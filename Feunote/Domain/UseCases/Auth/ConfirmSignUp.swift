//
//  CreateUser.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/17.
//

import Foundation

import Foundation
import Amplify


class ConfirmSignUpUseCase: ConfirmSignUpUseCaseProtocol{

    private let manager:AppRepositoryManagerProtocol

    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    /// You may wonder why it doesn't setup user model in datastore. Because their is a listener to the auth state. Once signed in, the user model in datastore will be set automatically.
    func execute(username:String, password:String,confirmationCode:String) async throws -> AuthStep{
        /*
        do {
            try await manager.authRepo.confirmSignUpAndSignIn(username: username, password: password, confirmationCode: confirmationCode)
            let authUser = manager.authRepo.authUser
            let pcitureKey = "\(user.)"
            try await manager.storageService.
            let user = User(id:userID, avatarURL: "", nickName: authUser?.username)
            try manager.dataStoreRepo.saveUser(user)
        }
         */
        
        return try await manager.authRepo.confirmSignUpAndSignIn(username: username, password: password, confirmationCode: confirmationCode)
    }
    
    
    }
