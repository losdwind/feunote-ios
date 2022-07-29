//
//  FeuBranch.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/26.
//

import Foundation
public struct FeuBranch:Identifiable,Hashable {
    public static func == (lhs: FeuBranch, rhs: FeuBranch) -> Bool {
        return lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public init(){
        self.init(id: UUID().uuidString, privacyType:PrivacyType.private, title: "", description: "", owner: nil, squadName:nil, actions: nil, commits: nil, numOfLikes: nil, numOfDislikes: nil, numOfComments: nil, numOfShares: nil, numOfSubs: nil, createdAt: nil, updatedAt: nil)
    }
    internal init(id: String = UUID().uuidString, privacyType:PrivacyType, title: String, description: String, owner: String? = nil, squadName:String? = nil, actions: [AmplifyAction]? = nil,commits:[AmplifyCommit]? = nil, numOfLikes: Int? = nil, numOfDislikes: Int? = nil, numOfComments: Int? = nil, numOfShares: Int? = nil, numOfSubs: Int? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self.privacyType = privacyType
        self.title = title
        self.description = description
        self.owner = owner
        self.squadName = squadName
        self.actions = actions
        self.commits = commits
        self.numOfLikes = numOfLikes
        self.numOfDislikes = numOfDislikes
        self.numOfComments = numOfComments
        self.numOfShares = numOfShares
        self.numOfSubs = numOfSubs
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    public let id: String
    public let privacyType:PrivacyType
    public var title: String
    public var description: String
    public var owner: String?
    public var squadName: String?
    public var actions:[AmplifyAction]?
    public var commits:[AmplifyCommit]?
    public var numOfLikes: Int?
    public var numOfDislikes: Int?
    public var numOfComments: Int?
    public var numOfShares: Int?
    public var numOfSubs: Int?
    public var createdAt: Date?
    public var updatedAt: Date?
}
