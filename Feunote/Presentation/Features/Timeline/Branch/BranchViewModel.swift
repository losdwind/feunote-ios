//
//  BranchViewModel.swift.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/28.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
class BranchViewModel: ObservableObject {
    
    
    
    @Published var branch:Branch = Branch()
    @Published var localTimestamp:Date = Date()
    
    
    
    
    
    
    
    @Published var fetchedAllBranches: [Branch] = [Branch]()
    @Published var fetchedSharedBranches:[Branch] = [Branch]()
    
    
    
    
    
    // MARK: Upload Branch
    func uploadBranch(completion: @escaping (_ success: Bool) -> ()) {
        
        guard let userID = AuthViewModel.shared.userID else {
            print("userID is not valid here in fetchMoment function")
            completion(false)
            return
        }
        
        
        if branch.ownerID != userID && !branch.memberIDs.contains(userID){
            completion(false)
            print("this branch does not belongs to you")
            return
        }
        

        let document = COLLECTION_USERS.document(branch.ownerID).collection("branches").document(branch.id)
        
        
        do {
            try document.setData(from: branch)
            completion(true)
            return
            
        } catch let error {
            print("Error upload branch to Firestore: \(error)")
            completion(false)
            return
        }
        
    }
    
    
    // MARK: Delete branch
    
    func deleteBranch(branch: Branch, handler: @escaping (_ success: Bool) -> ()){
        
        guard let userID = AuthViewModel.shared.userID else {
            print("userID is not valid")
            return }
        
            let document = COLLECTION_USERS.document(userID).collection("branches").document(branch.id)
            document.delete() { err in
                if let err = err {
                    print("Error removing branch: \(err)")
                    handler(false)
                    return
                } else {
                    print("Branch successfully removed!")
                    handler(true)
                    return
                }
            }
       
        
    }
    
    func searchUser(email:String, completion: @escaping (_ users: [User]?) -> ()){
        guard AuthViewModel.shared.userID != nil else {
            print("userID is not valid here in like function")
            completion(nil)
            return
        }
        COLLECTION_USERS
            .whereField("email", isEqualTo: email)
        .getDocuments { (snapshot, error) in
            
            guard let documents = snapshot?.documents else {
                completion(nil)
                return
            }
            
           let users = documents.compactMap({try? $0.data(as: User.self)})

                completion(users)
                return

        }
        
    }
    
    
    
    
    // TODO: addSnapshotListener
    // MARK: get all branches
    func fetchAllBranchs(completion: @escaping (_ success: Bool) -> ()) {
        guard let userID = AuthViewModel.shared.userID else {
            print("userID is not valid here in fetchMoment function")
            completion(false)
            return
        }
        
        
        COLLECTION_USERS.document(userID).collection("branches")
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    completion(false)
                    return }
                self.fetchedAllBranches = documents.compactMap({try? $0.data(as: Branch.self)})
                completion(true)
                return
            }
            
    }
    
    
    
}
