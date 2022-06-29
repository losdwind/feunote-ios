//
//  DataStoreRepositoryImpl.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/11.
//

import Foundation
import Amplify
import Combine
import UIKit




class DataStoreRepositoryImpl:DataStoreRepositoryProtocol{
    func queryUsers(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [FeuUser] {
        

        let amplifyUsers = try await dataStoreService.query(AmplifyUser.self, where: predicate, sort: sortInput, paginate: paginationInput)
        return try await withThrowingTaskGroup(of: FeuUser.self){ group -> [FeuUser] in
            var feuUsers:[FeuUser] = [FeuUser]()
            for user in amplifyUsers {
                group.addTask {
                    return try await self.userDataTransformer(user: user)
                }
            }
            for try await feuUser in group {
                feuUsers.append(feuUser)
            }
            return feuUsers
            
        }
        
    }
    
    func queryCommits(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [FeuCommit] {
        let amplifyCommits = try await dataStoreService.query(AmplifyCommit.self, where: predicate, sort: sortInput, paginate: paginationInput)
        return try await withThrowingTaskGroup(of: FeuCommit.self){ group -> [FeuCommit] in
            var feuCommits:[FeuCommit] = [FeuCommit]()
            for commit in amplifyCommits {
                group.addTask {
                    return try await self.commitDataTransformer(commit: commit)
                }
            }
            for try await feuCommit in group {
                feuCommits.append(feuCommit)
            }
            return feuCommits
            
        }
        
    }
    
    func queryBranches(where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [FeuBranch] {
        let amplifyBranches = try await dataStoreService.query(AmplifyBranch.self, where: predicate, sort: sortInput, paginate: paginationInput)
        
        return try await withThrowingTaskGroup(of: FeuBranch.self){ group -> [FeuBranch] in
            var feuBranches:[FeuBranch] = [FeuBranch]()
            for branch in amplifyBranches {
                group.addTask {
                    return try await self.branchDataTransformer(branch: branch)
                }
            }
            for try await feuBranch in group {
                feuBranches.append(feuBranch)
            }
            return feuBranches
            
        }
        
    }
    
    
    func queryUser(byID: String) async throws -> FeuUser {
        let amplifyUser = try await dataStoreService.query(AmplifyUser.self, byId: byID)
        return try await userDataTransformer(user: amplifyUser)
    }
    
    func queryBranch(byID: String) async throws -> FeuBranch {
        let amplifyBranch = try await dataStoreService.query(AmplifyBranch.self, byId: byID)
         return try await branchDataTransformer(branch: amplifyBranch)
    }
    
    func queryCommit(byID: String) async throws -> FeuCommit {
        let amplifyCommit = try await dataStoreService.query(AmplifyCommit.self, byId: byID)
        return try await commitDataTransformer(commit: amplifyCommit)
    }
    
    
    func query<M:Model>(_ model: M.Type, where predicate: QueryPredicate?, sort sortInput: QuerySortInput?, paginate paginationInput: QueryPaginationInput?) async throws -> [M]  {
        return try await dataStoreService.query(model, where: predicate, sort: sortInput, paginate: paginationInput)
    }
    
//    func query<M:Model>(_ model: M.Type, byId: String) async throws -> M {
//        return try await dataStoreService.query(model, byId: byID)
//    }
    
    
    
    private let dataStoreService:DataStoreServiceProtocol
    private let storageService:StorageServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    internal init(dataStoreService: DataStoreServiceProtocol, storageService:StorageServiceProtocol) {
        self.dataStoreService = dataStoreService
        self.storageService = storageService
    }

    var amplifyUser: AmplifyUser? {
        dataStoreService.user
    }
    
    // MARK: Todo need to consider the issue
    @MainActor
    var feuUser: FeuUser? {
        var user:FeuUser?
        Task{
            user = await getFeuUser()
        }
        return user
    }
    
    
    private func getFeuUser() async -> FeuUser?{
        var user:FeuUser?
        if let amplifyUser = amplifyUser {
                do {
                        user = try await userDataTransformer(user: amplifyUser)
                } catch {
                    user = nil
                }
        } else {
            user = nil
        }
        
        return user
    }
    
    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError>? {
        dataStoreService.eventsPublisher
    }
    
    func configure(_ sessionStatePublisher: Published<SessionState>.Publisher) {
        dataStoreService.configure(sessionStatePublisher)
    }
    
    func dataStorePublisher<M:Model>(for model: M.Type) -> AnyPublisher<MutationEvent, DataStoreError> {
        dataStoreService.dataStorePublisher(for: model)
    }
    


    
    
    
    func saveUser(_ feuUser: FeuUser) async throws -> AmplifyUser{

        let amplifyUser = try await userDataTransformer(user: feuUser)
        return try await dataStoreService.saveUser(amplifyUser).asyncThrowing(error: AppError.failedToSave)


    }
    func saveBranch(_ branch: FeuBranch) async throws -> AmplifyBranch {
//        return try await withCheckedThrowingContinuation { continuation in
//            dataStoreService.saveBranch(branch).sink {
//                switch $0 {
//                case .failure(_):
//                    continuation.resume(throwing: AppError.failedToSave)
//                case .finished(data):
//                    continuation.resume(returning: data)
//                }
//            } receiveValue: { amplifyBranch in
//
//            }
        
        
        let amplifyBranch = try await branchDataTransformer(branch: branch)
        return try await dataStoreService.saveBranch(amplifyBranch).asyncThrowing(error: AppError.failedToSave)

            
//            { result in
//                // depending on the content of result, we either resume with a value or an error
//                switch result {
//                case .success(let data):
//                    continuation.resume(returning: data)
//                case .failure(_):
//                    continuation.resume(throwing: AppError.failedToSave)
//                }
//            }
        }
    
    
    func deleteBranch(_ branchID: String) async throws {
//        return try await withCheckedThrowingContinuation { continuation in
//            dataStoreService.deleteBranch(branchID){ result {
//                dataStoreService.deleteBranch(branchID).
//            }
//
//
//                in
//                // depending on the content of result, we either resume with a value or an error
//                switch result {
//                case .success(_):
//                    continuation.resume()
//                case .failure(_):
//                    continuation.resume(throwing: AppError.failedToDelete)
//                }
//            }
//        }
        
        
        try await dataStoreService.deleteBranch(branchID).asyncThrowing(error: AppError.failedToDelete)
    }
    
    func saveCommit(_ commit: FeuCommit) async throws -> AmplifyCommit {
//        return try await withCheckedThrowingContinuation { continuation in
//            dataStoreService.saveCommit(commit){ result in
//                // depending on the content of result, we either resume with a value or an error
//                switch result {
//                case .success(let data):
//                    continuation.resume(returning: data)
//                case .failure(_):
//                    continuation.resume(throwing: AppError.failedToSave)
//                }
//            }
//        }
        let amplifyCommit = try await commitDataTransformer(commit: commit)
        return try await dataStoreService.saveCommit(amplifyCommit).asyncThrowing(error: AppError.failedToSave)
        
    }
    
    func deleteCommit(_ commitID: String) async throws {
//        return try await withCheckedThrowingContinuation { continuation in
//            dataStoreService.deleteCommit(commitID){ result in
//                // depending on the content of result, we either resume with a value or an error
//                switch result {
//                case .success(_):
//                    continuation.resume()
//                case .failure(_):
//                    continuation.resume(throwing: AppError.failedToDelete)
//                }
//            }
//        }
        return try await dataStoreService.deleteCommit(commitID).asyncThrowing(error: AppError.failedToDelete)
    }
}

// data transformer
extension DataStoreRepositoryImpl {
    
    private func commitDataTransformer(commit:FeuCommit) async throws -> AmplifyCommit {
        
        guard let amplifyUser = amplifyUser, commit.id == amplifyUser.id else {throw AppError.failedToSave}

        var newCommit:AmplifyCommit

        
        newCommit = AmplifyCommit(id: commit.id, commitType: commit.commitType, owner: amplifyUser, titleOrName: commit.titleOrName, description: commit.description, photoKeys: nil, audioKeys: nil, videoKeys: nil, toBranch: nil, momentWordCount: commit.momentWordCount, todoCompletion: commit.todoCompletion, todoReminder: commit.todoReminder, todoStart: nil, todoEnd: nil, personPriority: commit.personPriority, personAddress: commit.personAddress, personBirthday: nil, personContact: commit.personContact, personAvatarKey: nil)
        
        
        // data transform date? -> Temporal.DateTime?
        if commit.todoStart != nil {
            newCommit.todoStart = Temporal.DateTime.init(commit.todoStart!)
        }
        if commit.todoEnd != nil {
            newCommit.todoEnd = Temporal.DateTime.init(commit.todoEnd!)
        }
        
        if commit.personBirthday != nil {
            newCommit.personBirthday = Temporal.Date.init(commit.personBirthday!)
        }
        
        
        
        
        // toBranch
        if commit.toBranch != nil {
            newCommit.toBranch = try await dataStoreService.query(AmplifyBranch.self, byId: commit.toBranch!.id)
            
        }
        
        // person avatar
        if (commit.personAvatar != nil) {
            let avatarPictureKey = "\(commit.id)/Commit/\(newCommit.id)/avatar"
            guard let pngData = commit.personAvatar!.pngFlattened(isOpaque: true) else {
                throw AppStorageError.fileCompressionError}
            
            newCommit.personAvatarKey = try await storageService.uploadImage(key: avatarPictureKey, data: pngData)
        }
        
        // person photos
        if (commit.photos != nil) {
            let pictureKey = "\(commit.id)/Commit/\(newCommit.id)/photos"
            let uploadedPictureKeys = try await withThrowingTaskGroup(of: String.self){ group -> [String] in
                
                var pictureKeys:[String] = [String]()
                
                for image in commit.photos! {
                    
                            group.addTask{
                                let newPictureKey = pictureKey + "/image_\(String(describing: index))"
                                guard let pngData = image.pngFlattened(isOpaque: true) else {throw AppStorageError.fileCompressionError}
                                return try await self.storageService.uploadImage(key: newPictureKey, data: pngData)
                            
                        }
                        
                }
                            
                
                for try await pictureKey in group {
                    pictureKeys.append(pictureKey)
                }
                
                return pictureKeys
            }
            
            // update the new Moment imageURL key
            newCommit.photoKeys = uploadedPictureKeys
        }
        
        
        // MARK: - Todo: upload audios
        // MARK: - Todo: upload videos
        
        return try await dataStoreService.saveCommit(newCommit).asyncThrowing(error: AppError.failedToSave)
    }

    private func commitDataTransformer(commit:AmplifyCommit) async throws -> FeuCommit {
        
        guard let feuUser = await feuUser, commit.id == feuUser.id else {throw AppError.failedToSave}

        var newCommit:FeuCommit
        
        newCommit = FeuCommit(commitType: commit.commitType, owner: feuUser, titleOrName: commit.titleOrName, description: commit.description, photos: nil, audios: nil, videos: nil, toBranch: nil, momentWordCount: commit.momentWordCount, todoCompletion: commit.todoCompletion, todoReminder: commit.todoReminder, todoStart: commit.todoStart?.foundationDate, todoEnd: commit.todoEnd?.foundationDate, personPriority: commit.personPriority, personAddress: commit.personAddress, personBirthday: commit.personBirthday?.foundationDate, personContact: commit.personContact, personAvatar: nil, createdAt: commit.createdAt?.foundationDate, updatedAt: commit.updatedAt?.foundationDate)
        
        if commit.photoKeys != nil, !(commit.photoKeys!.isEmpty) {
            let photos = try await withThrowingTaskGroup(of: UIImage.self){ group -> [UIImage] in
                
                var pictures:[UIImage] = [UIImage]()
                
                for key in commit.photoKeys! {
                    if let key = key {
                        group.addTask{
                            
                    // MARK: - Todo : default cracked image placeholder, this shall be implemented by viewmodel not here.
                            do {
                                let data = try await self.storageService.downloadImage(key: key)
                                if let image = UIImage(data: data) {
                                    return image
                                } else {
                                    return UIImage(systemName: "circle.dotted")!
                                }
                            } catch {
                                return UIImage(systemName: "exclamationmark.icloud")!
                            }
                        
                    }
                    }
                            
                        
                }
                            
                
                for try await picture in group {
                    pictures.append(picture)
                }
                
                return pictures
            }
            
            newCommit.photos = photos
        }
        
        
        // MARK: - TODO: audios and videos
        if commit.personAvatarKey != nil {
            do {
                let data = try await storageService.downloadImage(key: commit.personAvatarKey!)
                newCommit.personAvatar = UIImage(data: data)
            } catch {
                newCommit.personAvatar = UIImage(systemName: "person.fill")
            }
        }
        return newCommit
    }
    
    private func branchDataTransformer(branch:FeuBranch) async throws -> AmplifyBranch {
        guard let amplifyUser = amplifyUser, branch.id == amplifyUser.id else {throw AppError.failedToSave}

        var newBranch:AmplifyBranch
        newBranch = AmplifyBranch(id: branch.id, title: branch.title, description: branch.description, owner: amplifyUser, numOfLikes: branch.numOfLikes, numOfDislikes: branch.numOfDislikes, numOfComments: branch.numOfComments, numOfShares: branch.numOfShares, numOfSubs: branch.numOfSubs)
//
//        if branch.members != nil{
//            let branchMembers = try await withThrowingTaskGroup(of: AmplifyUser.self){ group -> [AmplifyUser] in
//
//                var amplifyUsers:[AmplifyUser] = [AmplifyUser]()
//            for user in branch.members! {
//                group.addTask {
//                    do {
//                        let amplifyUser = try await self.userDataTransformer(user: user)
//                    } catch {
//                        throw AppError.failedToRead
//                    }
//                }
//            }
//                for try await amplifyUser in group {
//                    amplifyUsers.append(amplifyUser)
//                }
//
//                return amplifyUsers
//        }
//            newBranch.members = branchMembers as List<BranchMembers>?
//
//        }
        
        
        

        return newBranch
        
    }
    
    private func branchDataTransformer(branch:AmplifyBranch) async throws -> FeuBranch {
        guard let feuUser = await feuUser, branch.id == feuUser.id else {throw AppError.failedToSave}

        var newBranch:FeuBranch
        
        newBranch = FeuBranch(id:branch.id, title: branch.title, description: branch.description, owner: feuUser, numOfLikes: branch.numOfLikes, numOfDislikes: branch.numOfDislikes, numOfComments: branch.numOfComments, numOfShares: branch.numOfShares, numOfSubs: branch.numOfSubs, createdAt: branch.createdAt?.foundationDate, updatedAt: branch.updatedAt?.foundationDate)
        return newBranch
    }
    
    private func userDataTransformer(user:FeuUser) async throws -> AmplifyUser {
        var amplifyUser = AmplifyUser(id: user.id, email: user.email, avatarKey: "", nickName: user.nickName, bio: user.bio, realName: user.realName, gender: user.gender, birthday: nil, address: user.address, phone: user.phone, job: user.job, income: user.income, marriage: user.marriage, socialMedia: user.socialMedia, interest: user.interest, bigFive: user.bigFive, wellbeingIndex: user.wellbeingIndex)
        
        if user.birthday != nil {
            amplifyUser.birthday = Temporal.Date(user.birthday!)
        }
        
        let avatarKey = "\(user.id)/User/\(user.id)/avatar"
        guard let pngData = user.avatarImage.pngFlattened(isOpaque: true) else {
            throw AppStorageError.fileCompressionError
            
        }
        let key = try await storageService.uploadImage(key: avatarKey, data: pngData)
        amplifyUser.avatarKey = key
        
        return amplifyUser
    }

    private func userDataTransformer(user:AmplifyUser) async throws -> FeuUser {
        
        var feuUser = FeuUser(email: user.email, avatarImage: UIImage(systemName: "person.fill")!, nickName: user.nickName, bio: user.bio, realName: user.realName, gender: user.gender, birthday: user.birthday?.foundationDate, address: user.address, phone: user.phone, job: user.job, income: user.income, marriage: user.marriage, socialMedia: user.socialMedia, interest: user.interest.flatMap { $0.flatMap{$0}}, bigFive: user.bigFive, wellbeingIndex: user.wellbeingIndex, createdAt: user.createdAt?.foundationDate, updatedAt: user.updatedAt?.foundationDate)
        
        do {
            let data = try await storageService.downloadImage(key: user.avatarKey)
            if let image = UIImage(data: data) {
                feuUser.avatarImage = image
            } else {
                feuUser.avatarImage = UIImage(systemName: "person.fill")!
            }
        } catch {
            feuUser.avatarImage = UIImage(systemName: "circle.dotted")!
        }
        
        return feuUser

    }

}
