//
//  SquadViewModel.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/2.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import OrderedCollections

class SquadViewModel: ObservableObject {
    
    // for branches
    @Published var fetchedOnInviteBranches:[Branch]  = [Branch]()
    
    
    
    // for a specific branch
    @Published var fetchedMessages:[Message] = [Message]()
    @Published var fetchedProfiles:[User] = [User]()
    
    // for edit the
//    @Published var editBranch:Branch = Branch()
    @Published var currentBranch:Branch = Branch()
    @Published var inputMessage:Message = Message()

    
    // get the profiles of a branch by user ids
    func fetchProfiles(ids: [String], completion: @escaping (_ users: [User]?) -> () ){
    
        
        var users:[User] = []
        
        if !ids.isEmpty {
        COLLECTION_USERS
            .whereField("id", in: ids)
            .getDocuments { (snapshot, _) in
                guard let documents = snapshot?.documents else {
                    completion(nil)
                    return }
                users = documents.compactMap({try? $0.data(as: User.self)})
                completion(users)
    }
        } else {
            completion(nil)
            return
        }
    }
    
    
    


    
    
    func sendMessage(completion: @escaping (_ success: Bool) -> ()){
        
        // MARK: here we shall have an authentication that user is in the member list
        
        guard let userID = AuthViewModel.shared.userID else {
            print("userID is not valid here in like function")
            completion(false)
            return
        }
        
        self.inputMessage.userID = userID
        self.inputMessage.userProfileImageURL = AuthViewModel.shared.profileImageURL
        self.inputMessage.nickName = AuthViewModel.shared.nickName
        self.inputMessage.branchID = self.currentBranch.id
        
        
        let document =  COLLECTION_USERS.document(self.currentBranch.ownerID).collection("branches")
            .document(self.currentBranch.id).collection("messages").document(self.inputMessage.id)
        do {
            try document.setData(from: self.inputMessage)
            completion(true)
            return
            
        } catch let error {
            print("Error upload message to branch: \(error)")
            completion(false)
            return
        }
        
    }
    
    // FIXME: - here this function will result in too much call to fetch messages, please check the console log
    func getMessages(branch:Branch, completion: @escaping (_ success: Bool) -> ()) {
        
        COLLECTION_USERS.document(branch.ownerID).collection("branches").document(branch.id).collection("messages")
            .order(by:"serverTimestamp")
            .limit(to:20)
            .addSnapshotListener { (snapshot, _) in
                    guard let documents = snapshot?.documents else { return }
                    self.fetchedMessages = documents.compactMap({try? $0.data(as: Message.self)})
            
            completion(true)
        }
    
    }
   
    
    // MARK: get OnInvite branches, branchid can only been exist as either a ownerid or a member id
   
    func fetchOnInviteBranches(completion: @escaping (_ success: Bool) -> ()) {
        guard let userID = AuthViewModel.shared.userID else {
            print("userID is not valid here in fetchMoment function")
            completion(false)
            return
        }
        
        COLLECTION_BRANCHES
            .whereField("openness", isEqualTo: OpenType.OnInvite.rawValue)
            .whereField("memberIDs", arrayContains: userID)
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    completion(false)
                    return
                }
                
                self.fetchedOnInviteBranches = documents.compactMap({try? $0.data(as: Branch.self)})

                    completion(true)
                    return
    
            }

        
    }
    

    
}
