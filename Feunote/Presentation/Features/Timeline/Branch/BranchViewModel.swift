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
    internal init(saveBranchUserCase: SaveBranchUseCaseProtocol, getAllBranchesUseCase: GetAllBranchesUseCaseProtocol, deleteBranchUseCase: DeleteBranchUseCaseProtocol, getProfilesByIDsUserCase: GetProfilesByIDsUseCaseProtocol, viewDataMapper: ViewDataMapper) {
        self.saveBranchUserCase = saveBranchUserCase
        self.getAllBranchesUseCase = getAllBranchesUseCase
        self.deleteBranchUseCase = deleteBranchUseCase
        self.getProfilesByIDsUserCase = getProfilesByIDsUserCase
        self.viewDataMapper = viewDataMapper
    }

    private var saveBranchUserCase:SaveBranchUseCaseProtocol
    private var getAllBranchesUseCase:GetAllBranchesUseCaseProtocol
    private var deleteBranchUseCase:DeleteBranchUseCaseProtocol
    private var getProfilesByIDsUserCase:GetProfilesByIDsUseCaseProtocol
    private var viewDataMapper:ViewDataMapper
    
    
    
    @Published var branch:FeuBranch = FeuBranch(id: UUID().uuidString, title: "", description: "", owner: FeuUser(username: "", email: "123456@gmail.com", avatarImage: UIImage(), nickName: ""))
    
    @Published var fetchedAllBranches: [FeuBranch] = [FeuBranch]()
    @Published var fetchedSharedBranches:[FeuBranch] = [FeuBranch]()
    @Published var fetchedUsers:[FeuUser]?
    @Published var hasError = false
    @Published var appError:AppError?
    

    
    
    // MARK: Upload FeuBranch
    func saveBranch() async {
        do {
            let amplifyBranch = try await viewDataMapper.branchDataTransformer(branch: branch)
            try await saveBranchUserCase.execute(branch: amplifyBranch)
            branch = FeuBranch(id: UUID().uuidString, title: "", description: "", owner: FeuUser(username: "nameless", email: "123456@gmail.com", avatarImage: UIImage(), nickName: ""))
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
    func fetchAllBranchs(page:Int) async{
        do {
            
            let fetchedAmplifyBranches = try await getAllBranchesUseCase.execute(page: page)
            
            self.fetchedAllBranches = try await withThrowingTaskGroup(of: FeuBranch.self){ group -> [FeuBranch] in
                var feuBranches:[FeuBranch] = [FeuBranch]()
                for branch in fetchedAmplifyBranches {
                    group.addTask {
                        return try await self.viewDataMapper.branchDataTransformer(branch: branch)
                    }
                }
                for try await feuBranch in group {
                    feuBranches.append(feuBranch)
                }
                return feuBranches
                
            }
            
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
            
    }
    
    
    func fetchMembersByIDs(userIDs:[String]) async {
        do {
            let amplifyUSers = try await getProfilesByIDsUserCase.execute(userIDs:userIDs)
            
            self.fetchedUsers = try await withThrowingTaskGroup(of: FeuUser.self){ group -> [FeuUser] in
                var feuUsers:[FeuUser] = [FeuUser]()
                for user in amplifyUSers {
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
