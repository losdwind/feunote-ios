//
//  FakeDataMapper.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/20.
//

import Foundation

//
//  DataMapper.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/5.
//

import Foundation
import Amplify
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
                
        newBranch = FeuBranch(id:branch.id, privacyType: branch.privacyType, title: branch.title, description: branch.description, owner: branch.owner,members: branch.members, commits: branch.commits, numOfLikes: branch.numOfLikes, numOfDislikes: branch.numOfDislikes, numOfComments: branch.numOfComments, numOfShares: branch.numOfShares, numOfSubs: branch.numOfSubs, createdAt: branch.createdAt?.foundationDate, updatedAt: branch.updatedAt?.foundationDate)
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
