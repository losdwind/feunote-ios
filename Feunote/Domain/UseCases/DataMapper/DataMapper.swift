//
//  DataMapper.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/5.
//

import Foundation
import Amplify

// MARK: - Protocol
protocol ViewDataMapperProtocol {
    func commitDataTransformer(commit:FeuCommit) async throws -> AmplifyCommit
    func commitDataTransformer(commit:AmplifyCommit) async throws -> FeuCommit
    func branchDataTransformer(branch:FeuBranch) async throws -> AmplifyBranch
    func branchDataTransformer(branch:AmplifyBranch) async throws -> FeuBranch
    func userDataTransformer(user:FeuUser) async throws -> AmplifyUser
    func userDataTransformer(user:AmplifyUser) async throws -> FeuUser
}

// MARK: - Fake
class FakeViewDataMapper:ViewDataMapperProtocol {
    
    func commitDataTransformer(commit:FeuCommit) async throws -> AmplifyCommit {
        switch commit.commitType {
        case .moment:
            return fakeAmplifyMoment1
        case .person:
            return fakeAmplifyPerson1
        case .todo:
            return fakeAmplifyTodo1
        }
    }
    
    func commitDataTransformer(commit:AmplifyCommit) async throws -> FeuCommit {
        
        var newCommit:FeuCommit
                
        
        newCommit = FeuCommit(id:commit.id, commitType: commit.commitType, owner: commit.owner, titleOrName: commit.titleOrName, description: commit.description, photos: nil, audios: nil, videos: nil, toBranch: commit.toBranch, momentWordCount: commit.momentWordCount, todoCompletion: commit.todoCompletion, todoReminder: commit.todoReminder, todoStart: commit.todoStart?.foundationDate, todoEnd: commit.todoEnd?.foundationDate, personPriority: commit.personPriority, personAddress: commit.personAddress, personBirthday: commit.personBirthday?.foundationDate, personContact: commit.personContact, personAvatar: nil, createdAt: commit.createdAt?.foundationDate, updatedAt: commit.updatedAt?.foundationDate)
        
        if commit.photoKeys != nil, !(commit.photoKeys!.isEmpty) {
            var pictures:[UIImage?] = [UIImage?]()
            for imageKey in commit.photoKeys! {
                if imageKey != nil {
                    pictures.append(UIImage(named: "demo-photo-\(commit.photoKeys!.count % 7 + 1)"))
                } else {
                    pictures.append(nil)
                }
            }
           
            newCommit.photos = pictures
        }
        
        // MARK: - TODO: audios and videos
        if commit.personAvatarKey != nil {
            newCommit.personAvatar = UIImage(named: "demo-photo-1")
        }
        
        if commit.audioKeys != nil {
            var audios:[NSData?] = [NSData?]()
            for audioKey in commit.audioKeys! {
                if audioKey != nil {
                    audios.append(NSData())
                } else {
                    audios.append(nil)
                }
            }
           
            newCommit.audios = audios
        }
        
        if commit.videoKeys != nil {
            var videos:[NSData?] = [NSData?]()
            for videoKey in commit.videoKeys! {
                if videoKey != nil {
                    videos.append(NSData())
                } else {
                    videos.append(nil)
                }
            }
           
            newCommit.videos = videos
        }
        
        
        
        return newCommit
    }
    
    func branchDataTransformer(branch:FeuBranch) async throws -> AmplifyBranch {
        return fakeAmplifyBranchOpen1
    }
    
    func branchDataTransformer(branch:AmplifyBranch) async throws -> FeuBranch {
        //        guard let feuUser = await feuUser, branch.id == feuUser.id else {
        //            print("error in function branchDataTransformer(branch:AmplifyBranch)")
        //            throw AppError.failedToSave}
        
        var newBranch:FeuBranch
                
        newBranch = FeuBranch(id:branch.id, privacyType: branch.privacyType, title: branch.title, description: branch.description, owner: branch.owner, squadName: branch.squadName, members: branch.members, commits: branch.commits, numOfLikes: branch.numOfLikes, numOfDislikes: branch.numOfDislikes, numOfComments: branch.numOfComments, numOfShares: branch.numOfShares, numOfSubs: branch.numOfSubs, createdAt: branch.createdAt?.foundationDate, updatedAt: branch.updatedAt?.foundationDate)
        return newBranch
    }
    
    
    
    func userDataTransformer(user:FeuUser) async throws -> AmplifyUser {
        return fakeAmplifyUser1
    }
    
    func userDataTransformer(user:AmplifyUser) async throws -> FeuUser {
        
        var feuUser = FeuUser(id: user.id, username: user.username, owner: user.owner, email: user.email, avatarImage: nil, nickName: user.nickName, bio: user.bio, realName: user.realName, gender: user.gender, birthday: user.birthday?.foundationDate, address: user.address, phone: user.phone, job: user.job, income: user.income, marriage: user.marriage, socialMedia: user.socialMedia, interest: user.interest, bigFive: user.bigFive, wellbeingIndex: user.wellbeingIndex, createdAt: user.createdAt?.foundationDate, updatedAt: user.updatedAt?.foundationDate)
        
        if user.avatarKey != nil {
            feuUser.avatarImage = UIImage(named: "demo-photo-2")
        }

        return feuUser
        
    }
    
}


// MARK: - Production
class ViewDataMapper:ViewDataMapperProtocol {
    
    private let manager:AppRepositoryManagerProtocol
    
    init(manager:AppRepositoryManagerProtocol = AppRepoManager.shared){
        self.manager = manager
    }
    
    func commitDataTransformer(commit:FeuCommit) async throws -> AmplifyCommit {
        
        //        guard let amplifyUser = amplifyUser, commit.id == amplifyUser.id else {
        //            print("error in func commitDataTransformer(commit:FeuCommit), item do not belongs to current user ")
        //            throw AppError.failedToSave
        //
        //        }
        
        var newCommit:AmplifyCommit
                
        
        newCommit = AmplifyCommit(id: commit.id, owner: commit.owner, commitType: commit.commitType, titleOrName: commit.titleOrName, description: commit.description, photoKeys: nil, audioKeys: nil, videoKeys: nil, toBranch: commit.toBranch, momentWordCount: commit.momentWordCount, todoCompletion: commit.todoCompletion, todoReminder: commit.todoReminder, todoStart: nil, todoEnd: nil, personPriority: commit.personPriority, personAddress: commit.personAddress, personBirthday: nil, personContact: commit.personContact, personAvatarKey: nil)
        
        
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
        
        
        
//
//        // toBranch
//        if commit.toBranch != nil {
//            do {
//                newCommit.toBranch = try await manager.dataStoreRepo.queryBranch(byID: commit.toBranch!)
//            } catch(_) {
//                print("Error: failed to get branch from ID when mapping feuCommit to amplifyCommit")
//                throw AppError.failedToRead
//            }
//
//
//        }
        
        // person avatar
        if (commit.personAvatar != nil) {
            let avatarPictureKey = "\(commit.id)/Commit/\(newCommit.id)/avatar"
            guard let pngData = commit.personAvatar!.pngFlattened(isOpaque: true) else {
                print("error to compress image")
                throw AppStorageError.fileCompressionError}
            
            newCommit.personAvatarKey = try await manager.storageRepo.uploadImage(key: avatarPictureKey, data: pngData)
        }
        
        // person photos
        if (commit.photos != nil) {
            let pictureKey = "\(commit.id)/Commit/\(newCommit.id)/photos"
            let uploadedPictureKeys = try await withThrowingTaskGroup(of: String.self){ group -> [String] in
                
                var pictureKeys:[String] = [String]()
                
                for image in commit.photos! {
                    if let image = image {
                        group.addTask{
                            let newPictureKey = pictureKey + "/image_\(String(describing: index))"
                            guard let pngData = image.pngFlattened(isOpaque: true) else {
                                print("error to compress image")
                                throw AppStorageError.fileCompressionError}
                            return try await self.manager.storageRepo.uploadImage(key: newPictureKey, data: pngData)
                            
                        }
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
        return newCommit
    }
    
    func commitDataTransformer(commit:AmplifyCommit) async throws -> FeuCommit {
        //
        //        guard let feuUser = await feuUser, commit.id == feuUser.id else {
        //            print("error in func commitDataTransformer(commit:AmplifyCommit), item do not belongs to current user")
        //            throw AppError.failedToSave}
        
        var newCommit:FeuCommit
                
        
        newCommit = FeuCommit(id:commit.id, commitType: commit.commitType, owner: commit.owner, titleOrName: commit.titleOrName, description: commit.description, photos: nil, audios: nil, videos: nil, toBranch: commit.toBranch, momentWordCount: commit.momentWordCount, todoCompletion: commit.todoCompletion, todoReminder: commit.todoReminder, todoStart: commit.todoStart?.foundationDate, todoEnd: commit.todoEnd?.foundationDate, personPriority: commit.personPriority, personAddress: commit.personAddress, personBirthday: commit.personBirthday?.foundationDate, personContact: commit.personContact, personAvatar: nil, createdAt: commit.createdAt?.foundationDate, updatedAt: commit.updatedAt?.foundationDate)
        
        if commit.photoKeys != nil, !(commit.photoKeys!.isEmpty) {
            let photos = try await withThrowingTaskGroup(of: UIImage?.self){ group -> [UIImage?] in
                
                var pictures:[UIImage?] = [UIImage?]()
                
                for key in commit.photoKeys! {
                    if let key = key {
                        group.addTask{
                            
                            // MARK: - Todo : default cracked image placeholder, this shall be implemented by viewmodel not here.
                            do {
                                let data = try await self.manager.storageRepo.downloadImage(key: key)
                                if let image = UIImage(data: data) {
                                    return image
                                } else {
                                    return nil
                                }
                            } catch {
                                return nil
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
                let data = try await manager.storageRepo.downloadImage(key: commit.personAvatarKey!)
                newCommit.personAvatar = UIImage(data: data)
            } catch {
                newCommit.personAvatar = nil
            }
        }
        return newCommit
    }
    
    func branchDataTransformer(branch:FeuBranch) async throws -> AmplifyBranch {
        //        guard let amplifyUser = amplifyUser, branch.id == amplifyUser.id else {
        //            print("error in branchDataTransformer(branch:FeuBranch), item does not belong to user")
        //            throw AppError.failedToSave}
        
        var newBranch:AmplifyBranch
        
        newBranch = AmplifyBranch(id: branch.id, owner: branch.owner, privacyType: branch.privacyType, title: branch.title, description: branch.description,members: branch.members, commits: branch.commits, numOfLikes: branch.numOfLikes, numOfDislikes: branch.numOfDislikes, numOfComments: branch.numOfComments, numOfShares: branch.numOfShares, numOfSubs: branch.numOfSubs)
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
    
    func branchDataTransformer(branch:AmplifyBranch) async throws -> FeuBranch {
        //        guard let feuUser = await feuUser, branch.id == feuUser.id else {
        //            print("error in function branchDataTransformer(branch:AmplifyBranch)")
        //            throw AppError.failedToSave}
        
        var newBranch:FeuBranch
                
        newBranch = FeuBranch(id:branch.id, privacyType: branch.privacyType, title: branch.title, description: branch.description, owner: branch.owner,members: branch.members, commits: branch.commits, numOfLikes: branch.numOfLikes, numOfDislikes: branch.numOfDislikes, numOfComments: branch.numOfComments, numOfShares: branch.numOfShares, numOfSubs: branch.numOfSubs, createdAt: branch.createdAt?.foundationDate, updatedAt: branch.updatedAt?.foundationDate)
        return newBranch
    }
    
    
    
    func userDataTransformer(user:FeuUser) async throws -> AmplifyUser {

        var amplifyUser = AmplifyUser(id: user.id, owner: user.owner, nickName: user.nickName, avatarKey: nil, bio: user.bio, username: user.username, email: user.email, realName: user.realName, gender: user.gender, birthday: nil, address: user.address, phone: user.phone, job: user.job, income: user.income, marriage: user.marriage, socialMedia: user.socialMedia, interest: user.interest, bigFive: user.bigFive, wellbeingIndex: user.wellbeingIndex)
        
        if user.birthday != nil {
            amplifyUser.birthday = Temporal.Date(user.birthday!)
        }
        
        if user.avatarImage != nil {
            let avatarKey = "/avatar/\(user.id)"
            guard let pngData = user.avatarImage!.pngFlattened(isOpaque: true) else {
                print("error to compress image")
                throw AppStorageError.fileCompressionError
                
            }
            let key = try await manager.storageRepo.uploadImage(key: avatarKey, data: pngData)
            amplifyUser.avatarKey = key
        }
        
        
        return amplifyUser
    }
    
    func userDataTransformer(user:AmplifyUser) async throws -> FeuUser {
        
        var feuUser = FeuUser(id: user.id, username: user.username, owner: user.owner, email: user.email, avatarImage: nil, nickName: user.nickName, bio: user.bio, realName: user.realName, gender: user.gender, birthday: user.birthday?.foundationDate, address: user.address, phone: user.phone, job: user.job, income: user.income, marriage: user.marriage, socialMedia: user.socialMedia, interest: user.interest, bigFive: user.bigFive, wellbeingIndex: user.wellbeingIndex, createdAt: user.createdAt?.foundationDate, updatedAt: user.updatedAt?.foundationDate)
        
        if user.avatarKey != nil {
            do {
                let data = try await manager.storageRepo.downloadImage(key: user.avatarKey!)
                if let image = UIImage(data: data) {
                    feuUser.avatarImage = image
                } else {
                    feuUser.avatarImage = nil
                }
            } catch {
                feuUser.avatarImage = nil
            }
        }
            
        
        
        return feuUser
        
    }
    
}
