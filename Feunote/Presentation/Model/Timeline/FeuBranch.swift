//
//  FeuBranch.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/26.
//

import Foundation
public struct FeuBranch:Identifiable,Hashable {
    public init(){
        self.init(id: UUID().uuidString, title: "This is a demo branch", description: "This is a demo branch which is used for test. It do not contains any useful info", owner: FeuUser(), members: [FeuUser(),FeuUser(),FeuUser()], numOfLikes: 123, numOfDislikes: 1312, numOfComments: 1241241, numOfShares: 13, numOfSubs: 12312, createdAt: Date.now, updatedAt: Date.now.addingTimeInterval(10))
    }
    internal init(id: String, title: String, description: String, owner: FeuUser, members: [FeuUser]? = nil, numOfLikes: Int? = nil, numOfDislikes: Int? = nil, numOfComments: Int? = nil, numOfShares: Int? = nil, numOfSubs: Int? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.owner = owner
        self.members = members
        self.numOfLikes = numOfLikes
        self.numOfDislikes = numOfDislikes
        self.numOfComments = numOfComments
        self.numOfShares = numOfShares
        self.numOfSubs = numOfSubs
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    public let id: String
    public var title: String
    public var description: String
    public var owner: FeuUser
    public var members: [FeuUser]?
//    public var commits: [FeuCommit]?
//    public var actions: [FeuAction]?
    public var numOfLikes: Int?
    public var numOfDislikes: Int?
    public var numOfComments: Int?
    public var numOfShares: Int?
    public var numOfSubs: Int?
    public var createdAt: Date?
    public var updatedAt: Date?
}
