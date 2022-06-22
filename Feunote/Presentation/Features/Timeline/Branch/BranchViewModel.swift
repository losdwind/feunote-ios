//
//  BranchViewModel.swift.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/28.
//

import Foundation

class BranchViewModel: ObservableObject {
    internal init(saveBranchUserCase: SaveBranchUseCaseProtocol, getAllBranches: GetAllBranchesUseCaseProtocol, deleteBranchUseCase: DeleteBranchUseCaseProtocol) {
        self.saveBranchUserCase = saveBranchUserCase
        self.getAllBranches = getAllBranches
        self.deleteBranchUseCase = deleteBranchUseCase
    }

    private var saveBranchUserCase:SaveBranchUseCaseProtocol
    private var getAllBranchesUseCase:GetAllBranchesUseCaseProtocol
    private var deleteBranchUseCase:DeleteBranchUseCaseProtocol
    
    
    
    @Published var branch:Branch = Branch()
    @Published var localTimestamp:Date = Date()
    
    @Published var fetchedAllBranches: [Branch] = [Branch]()
    @Published var fetchedSharedBranches:[Branch] = [Branch]()
    
    @Published var hasError = false
    @Published var appError:AppError
    

    
    
    // MARK: Upload Branch
    func saveBranch() async {
        do {
            try await saveBranchUserCase.execute(existingBranch: branch, title: branch.title, description: branch.description, members: branch.members)
            branch = Branch()
        } catch(let error){
            hasError = true
            appError = error
        }
        
        
    }
    
    
    // MARK: Delete branch
    
    func deleteBranch(branch: Branch) async{
        do {
            try await deleteBranchUseCase.execute(branch: branch)
        } catch(let error){
            hasError = true
            appError = error
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
            appError = error
        }
            
    }
    
    
    
}
