//
//  CommitViewModel.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/8.
//

import Foundation
import SwiftUI

class CommitViewModel:ObservableObject {
    internal init(saveCommitUseCase: SaveCommitUseCaseProtocol, deleteCommitUseCase: DeleteCommitUseCaseProtocol, getAllCommitsUseCase: GetAllCommitsUseCaseProtocol) {
        self.saveCommitUseCase = saveCommitUseCase
        self.deleteCommitUseCase = deleteCommitUseCase
        self.getAllCommitsUseCase = getAllCommitsUseCase
    }
    
    
    
    @Published var commit = FeuCommit(commitType: CommitType.moment, owner: FeuUser(email: "s12312434@gmail.com", avatarImage: UIImage(systemName: "person.fill")!, nickName: "kk") )
    
    @Published var fetchedAllCommits:[FeuCommit] = [FeuCommit]()
        
    private var saveCommitUseCase:SaveCommitUseCaseProtocol
    private var deleteCommitUseCase:DeleteCommitUseCaseProtocol
    private var getAllCommitsUseCase:GetAllCommitsUseCaseProtocol

    @Published var hasError = false
    @Published var appError:AppError?
    
    func saveCommit() async{
        do {
            try await saveCommitUseCase.execute(commit: self.commit)
            playSound(sound: "sound-ding", type: "mp3")
            self.commit = FeuCommit(commitType: CommitType.moment, owner: FeuUser(email: "s12312434@gmail.com", avatarImage: UIImage(systemName: "person.fill")!, nickName: "kk") )
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
        
    }
    
    
    func deleteCommit(commit: FeuCommit) async {
        
        do {
            try await deleteCommitUseCase.execute(commit: commit)
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
    }
    
    
    func getAllCommits(page: Int) async{
        do {
            fetchedAllCommits = try await getAllCommitsUseCase.execute(page: page)
            
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
    }
    
    
    func getTodayCommits() async -> [FeuCommit] {
        return [FeuCommit]()
    }

    
    
    
}
