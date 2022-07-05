//
//  Commit.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/26.
//

import Foundation
import SwiftUI

public struct FeuCommit: Hashable,Identifiable {
    
    public init(){
        self.init(commitType: CommitType.moment, owner: FeuUser(), titleOrName: "This is a demo Commit", description: "This is a demo commit without any useful info", photos: [UIImage(systemName: "person.fill")!], audios: nil, videos: nil, toBranch: FeuBranch(), momentWordCount: 1232, todoCompletion: true, todoReminder: true, todoStart: Date.now, todoEnd: Date.now.addingTimeInterval(12), personPriority: 2, personAddress: "Somewhere on earth", personBirthday: Date.init(timeIntervalSince1970: 10000), personContact: "1000000", personAvatar: UIImage(systemName: "person.fill"), createdAt: Date.now, updatedAt: Date.now.addingTimeInterval(100))
    }
    
    
    
    internal init(commitType: CommitType, owner: FeuUser, titleOrName: String? = nil, description: String? = nil, photos: [UIImage]? = nil, audios: [NSData]? = nil, videos: [NSData]? = nil, toBranch: FeuBranch? = nil, momentWordCount: Int? = nil, todoCompletion: Bool? = nil, todoReminder: Bool? = nil, todoStart: Date? = nil, todoEnd: Date? = nil, personPriority: Int? = nil, personAddress: String? = nil, personBirthday: Date? = nil, personContact: String? = nil, personAvatar: UIImage? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.commitType = commitType
        self.owner = owner
        self.titleOrName = titleOrName
        self.description = description
        self.photos = photos
        self.audios = audios
        self.videos = videos
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
    
    
    public let id: String = UUID().uuidString
    public var commitType: CommitType
    public var owner: FeuUser
    public var titleOrName: String?
    public var description: String?
    public var photos: [UIImage]?
    public var audios: [NSData]?
    public var videos: [NSData]?
    public var toBranch: FeuBranch?
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
