//
//  Commit.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/26.
//

import Foundation
import SwiftUI
public struct FeuCommit: Hashable,Identifiable {
    public static func == (lhs: FeuCommit, rhs: FeuCommit) -> Bool {
        return lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    internal init(id:String = UUID().uuidString, commitType: CommitType, owner: String? = nil, titleOrName: String? = nil, description: String? = nil, photos: [UIImage]? = nil, audios: [NSData]? = nil, videos: [NSData]? = nil,toBranchID:String? = nil, toBranch: AmplifyBranch? = nil, momentWordCount: Int? = nil, todoCompletion: Bool? = nil, todoReminder: Bool? = nil, todoStart: Date? = nil, todoEnd: Date? = nil, personPriority: Int? = nil, personAddress: String? = nil, personBirthday: Date? = nil, personContact: String? = nil, personAvatar: UIImage? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self.commitType = commitType
        self.owner = owner
        self.titleOrName = titleOrName
        self.description = description
        self.photos = photos
        self.audios = audios
        self.videos = videos
        self.toBranchID = toBranchID
        self.toBranch = toBranch
        self.momentWordCount = momentWordCount
        self.todoCompletion = todoCompletion
        self.todoReminder = todoReminder
        self.todoStart = todoStart
        self.todoEnd = todoEnd
        self.personPriority = personPriority
        self.personAddress = personAddress
        self.personBirthday = personBirthday
        self.personContact = personContact
        self.personAvatar = personAvatar
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    
    public init(){
        self.init(id:UUID().uuidString, commitType: CommitType.moment, owner:nil, titleOrName: nil, description: nil, photos: nil, audios: nil, videos: nil,toBranchID: nil, toBranch: nil, momentWordCount: nil, todoCompletion: nil, todoReminder: nil, todoStart: nil, todoEnd: nil, personPriority: nil, personAddress: nil, personBirthday: nil, personContact: nil, personAvatar: nil, createdAt: nil, updatedAt: nil)
    }
    
    

    public let id: String
    public var commitType: CommitType
    public var owner: String?
    public var titleOrName: String?
    public var description: String?
    public var photos: [UIImage?]?
    public var audios: [NSData?]?
    public var videos: [NSData?]?
    public var toBranchID:String?
    public var toBranch: AmplifyBranch?
    public var momentWordCount: Int?
    public var todoCompletion: Bool?
    public var todoReminder: Bool?
    public var todoStart: Date?
    public var todoEnd: Date?
    public var personPriority: Int?
    public var personAddress: String?
    public var personBirthday: Date?
    public var personContact: String?
    public var personAvatar: UIImage?
    public var createdAt: Date?
    public var updatedAt: Date?
    
    
}
