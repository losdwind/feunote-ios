//
//  CommitViewModel.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/8.
//

import Foundation
import SwiftUI

@MainActor
class CommitViewModel:ObservableObject {
    internal init(saveCommitUseCase: SaveCommitUseCaseProtocol, deleteCommitUseCase: DeleteCommitUseCaseProtocol, getAllCommitsUseCase: GetAllCommitsUseCaseProtocol, viewDataMapper:ViewDataMapper) {
        self.saveCommitUseCase = saveCommitUseCase
        self.deleteCommitUseCase = deleteCommitUseCase
        self.getAllCommitsUseCase = getAllCommitsUseCase
        self.viewDataMapper = viewDataMapper
    }
    
    
    @Published var commit:FeuCommit = FeuCommit()
    
    @Published var fetchedAllCommits:[FeuCommit] = [FeuCommit]()
    @Published var fetchedAllMoments:[FeuCommit] = [FeuCommit]()
    @Published var fetchedAllTodos:[FeuCommit] = [FeuCommit]()
    @Published var fetchedAllPersons:[FeuCommit] = [FeuCommit]()
        
    private var saveCommitUseCase:SaveCommitUseCaseProtocol
    private var deleteCommitUseCase:DeleteCommitUseCaseProtocol
    private var getAllCommitsUseCase:GetAllCommitsUseCaseProtocol
    private var viewDataMapper:ViewDataMapper

    @Published var hasError = false
    @Published var appError:AppError?
    
    func saveCommit() async{
        do {
            
            print("before activate FeuCommit commitdatatransformer to amplifyCommit ")
            let amplifyCommit = try await viewDataMapper.commitDataTransformer(commit: self.commit)
            
            try await saveCommitUseCase.execute(commit: amplifyCommit)
            playSound(sound: "sound-ding", type: "mp3")
            print("success to save commit \(commit.commitType.rawValue.description)")

            self.commit = FeuCommit()
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
        
    }
    
    
    func deleteCommit(commitID: String) async {
        
        do {
            try await deleteCommitUseCase.execute(commitID: commitID)
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
    }
    
    
    func getAllCommits(page: Int) async{
        do {
            let fetchedAmplifyBranches = try await getAllCommitsUseCase.execute(page: page)
            self.fetchedAllCommits = try await withThrowingTaskGroup(of: FeuCommit.self){ group -> [FeuCommit] in
                var feuCommits:[FeuCommit] = [FeuCommit]()
                for commit in fetchedAmplifyBranches {
                    group.addTask {
                        return try await self.viewDataMapper.commitDataTransformer(commit: commit)
                    }
                }
                for try await feuCommit in group {
                    print("fetched feuCommit with ID: \(feuCommit.commitType.rawValue.description)")
                    feuCommits.append(feuCommit)
                }
                return feuCommits
                
            }
            
            self.fetchedAllMoments = self.fetchedAllCommits.filter({ commit in
                return commit.commitType == .moment
            })
            
            self.fetchedAllTodos = self.fetchedAllCommits.filter({ commit in
                return commit.commitType == .todo
            })
            
            self.fetchedAllPersons = self.fetchedAllCommits.filter({ commit in
                return commit.commitType == .person
            })
            
        } catch(let error){
            hasError = true
            appError = error as? AppError
        }
    }
    
    
    func getTodayCommits() async -> [FeuCommit] {
        return [FeuCommit]()
    }

    
    
    
}
