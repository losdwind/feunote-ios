//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import Amplify
// import AWSCognitoAuthPlugin
import AWSPluginsCore
import Combine
import Kingfisher

protocol AppRepositoryManagerProtocol {
    var authRepo: AuthRepositoryProtocol { get }
    var dataStoreRepo: DataStoreRepositoryProtocol { get }
    var storageRepo: StorageRepositoryProtocol { get }
    var remoteApiRepo: RemoteApiRepositoryProtocol { get }
    var errorTopic: PassthroughSubject<AmplifyError, Never> { get }
    var identityId:String {get}
    var usersub:String {get}
    func configure()
    func getIdentity() 
}

class AppRepoManager: AppRepositoryManagerProtocol {
    private init() {}
    
    static let shared = AppRepoManager()
    let authRepo: AuthRepositoryProtocol = AuthRepositoryImpl(authService: AmplifyAuthService())
    let dataStoreRepo: DataStoreRepositoryProtocol = DataStoreRepositoryImpl(dataStoreService: AmplifyDataStoreService(), storageService: AmplifyStorageService())
    let storageRepo: StorageRepositoryProtocol = StorageRepositoryImpl(storageService: AmplifyStorageService())
    var remoteApiRepo: RemoteApiRepositoryProtocol = RemoteApiRepositoryImpl()
    
    let errorTopic = PassthroughSubject<AmplifyError, Never>()
    
    func configure() {
        authRepo.configure()
        dataStoreRepo.configure(authRepo.sessionStatePublisher)
        getIdentity()
    }
    
    var usersub:String = ""
    var identityId:String  = ""
    
    func getIdentity() {
        Amplify.Auth.fetchAuthSession { result in
            do {
                let session = try result.get()
                
                // Get user sub or identity id
                if let identityProvider = session as? AuthCognitoIdentityProvider {
                    self.usersub = try identityProvider.getUserSub().get()
                    self.identityId = try identityProvider.getIdentityId().get()
                    print("User sub - \(self.usersub) and identity id \(self.identityId)")
                }
                
                //                // Get AWS credentials
                //                if let awsCredentialsProvider = session as? AuthAWSCredentialsProvider {
                //                    let credentials = try awsCredentialsProvider.getAWSCredentials().get()
                //                    // Do something with the credentials
                //                }
                //
                //                // Get cognito user pool token
                //                if let cognitoTokenProvider = session as? AuthCognitoTokensProvider {
                //                    let tokens = try cognitoTokenProvider.getCognitoTokens().get()
                //                    // Do something with the Cognito tokens
                //                }
                
            } catch {
                print("Fetch auth session failed with error - \(error)")
            }
        }
    }
}
