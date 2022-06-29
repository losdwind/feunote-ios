//
//  BranchViewModel.swift.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/28.
//

import Foundation
import SwiftUI
class BranchViewModel: ObservableObject {
    internal init(saveBranchUserCase: SaveBranchUseCaseProtocol, getAllBranchesUseCase: GetAllBranchesUseCaseProtocol, deleteBranchUseCase: DeleteBranchUseCaseProtocol) {
        self.saveBranchUserCase = saveBranchUserCase
        self.getAllBranchesUseCase = getAllBranchesUseCase
        self.deleteBranchUseCase = deleteBranchUseCase
    }

    private var saveBranchUserCase:SaveBranchUseCaseProtocol
    private var getAllBranchesUseCase:GetAllBranchesUseCaseProtocol
    private var deleteBranchUseCase:DeleteBranchUseCaseProtocol
    
    
    
    @Published var branch:FeuBranch = FeuBranch(id: UUID().uuidString, title: "", description: "", owner: FeuUser(email: "", avatarImage: UIImage(), nickName: ""))
    
    @Published var fetchedAllBranches: [FeuBranch] = [FeuBranch]()
    @Published var fetchedSharedBranches:[FeuBranch] = [FeuBranch]()
    
    @Published var hasError = false
    @Published var appError:AppError?
    

    
    
    // MARK: Upload FeuBranch
    func saveBranch() async {
        do {
            try await saveBranchUserCase.execute(branch: branch)
            branch = FeuBranch(id: UUID().uuidString, title: "", description: "", owner: FeuUser(email: "", avatarImage: UIImage(), nickName: ""))
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
        
        
    }
    
    
    // MARK: Delete branch
    
    func deleteBranch(branch: FeuBranch) async{
        do {
            try await deleteBranchUseCase.execute(branchID: branch.id)
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
            fetchedAllBranches = try await getAllBranchesUseCase.execute(page: page)
            
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
            
    }
    
    
    
}
