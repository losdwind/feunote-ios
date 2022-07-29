//
//  BranchViewModel.swift.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/28.
//

import Foundation
import SwiftUI

@MainActor
class BranchViewModel: ObservableObject {
    internal init(saveBranchUserCase: SaveBranchUseCaseProtocol, getOwnedBranchesUseCase: GetOwnedBranchesUseCaseProtocol, deleteBranchUseCase: DeleteBranchUseCaseProtocol, getProfilesByIDsUserCase: GetProfilesByIDsUseCaseProtocol, viewDataMapper: ViewDataMapperProtocol) {
        self.saveBranchUserCase = saveBranchUserCase
        self.getOwnedBranchesUseCase = getOwnedBranchesUseCase
        self.deleteBranchUseCase = deleteBranchUseCase
        self.getProfilesByIDsUserCase = getProfilesByIDsUserCase
        self.viewDataMapper = viewDataMapper
    }

    private var saveBranchUserCase:SaveBranchUseCaseProtocol
    private var getOwnedBranchesUseCase:GetOwnedBranchesUseCaseProtocol
    private var deleteBranchUseCase:DeleteBranchUseCaseProtocol
    private var getProfilesByIDsUserCase:GetProfilesByIDsUseCaseProtocol
    private var viewDataMapper:ViewDataMapperProtocol
    
    
    
    @Published var branch:FeuBranch = FeuBranch(privacyType: .private, title: "", description: "")

    @Published var fetchedAllFeuBranches: [FeuBranch] = [FeuBranch]()
    @Published var fetchedSharedFeuBranches:[FeuBranch] = [FeuBranch]()
    @Published var fetchedFeuUsers:[FeuUser] = []

    @Published var fetchedAllAmplifyBranches: [AmplifyBranch] = [AmplifyBranch]()
    @Published var fetchedSharedAmplifyBranches:[AmplifyBranch] = [AmplifyBranch]()
    @Published var fetchedAmplifyUsers:[AmplifyUser] = []

    @Published var hasError = false
    @Published var appError:AppError?
    

    
    
    // MARK: Upload FeuBranch
    func saveBranch() async {
        do {
            let amplifyBranch = try await viewDataMapper.branchDataTransformer(branch: branch)
            try await saveBranchUserCase.execute(branch: amplifyBranch)
            branch = FeuBranch(privacyType: .private, title: "", description: "")
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
        
        
    }
    
    
    // MARK: Delete branch
    
    func deleteBranch(branchID: String) async{
        do {
            try await deleteBranchUseCase.execute(branchID: branchID)
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
        
    }
    
//    func searchUser(email:String, completion: @escaping (_ users: [User]?) -> ()){
//        guard AuthViewModel.shared.userID != nil else {
//            print("userID is not valid here in like function")
//            completion(nil)
//            return
//        }
//        COLLECTION_USERS
//            .whereField("email", isEqualTo: email)
//        .getDocuments { (snapshot, error) in
//
//            guard let documents = snapshot?.documents else {
//                completion(nil)
//                return
//            }
//
//           let users = documents.compactMap({try? $0.data(as: User.self)})
//
//                completion(users)
//                return
//
//        }
//
//    }
    
    // add fetch listener
    func getAllBranchs(page:Int) async{
        do {
            
            self.fetchedAllAmplifyBranches = try await getOwnedBranchesUseCase.execute(page: page)
            
            self.fetchedAllFeuBranches = try await withThrowingTaskGroup(of: FeuBranch.self){ group -> [FeuBranch] in
                var feuBranches:[FeuBranch] = [FeuBranch]()
                for branch in fetchedAllAmplifyBranches {
                    group.addTask {
                        return try await self.viewDataMapper.branchDataTransformer(branch: branch)
                    }
                }
                for try await feuBranch in group {
                    print("fetched feuBranch with ID: \(feuBranch.id)")
                    feuBranches.append(feuBranch)
                }
                return feuBranches
                
            }
            
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
            
    }
    
    
    func getMembersByIDs(userIDs:[String]) async {
        do {
            self.fetchedAmplifyUsers = try await getProfilesByIDsUserCase.execute(userIDs:userIDs)
            
            self.fetchedFeuUsers = try await withThrowingTaskGroup(of: FeuUser.self){ group -> [FeuUser] in
                var feuUsers:[FeuUser] = [FeuUser]()
                for user in self.fetchedAmplifyUsers {
                    group.addTask {
                        return try await self.viewDataMapper.userDataTransformer(user: user)
                    }
                }
                for try await feuUser in group {
                    feuUsers.append(feuUser)
                }
                return feuUsers
                
            }
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
        
    }
    
    
    
}
