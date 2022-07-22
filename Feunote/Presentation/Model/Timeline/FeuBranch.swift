//
//  FeuBranch.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/26.
//

import Foundation
public struct FeuBranch:Identifiable,Hashable {
    public init(){
        self.init(id: UUID().uuidString, privacyType:PrivacyType.private, title: "", description: "", owner: nil, members: nil, commits: nil, numOfLikes: nil, numOfDislikes: nil, numOfComments: nil, numOfShares: nil, numOfSubs: nil, createdAt: nil, updatedAt: nil)
    }
    internal init(id: String = UUID().uuidString, privacyType:PrivacyType, title: String, description: String, owner: String? = nil, members: [String?]? = nil,commits:[String?]? = nil, numOfLikes: Int? = nil, numOfDislikes: Int? = nil, numOfComments: Int? = nil, numOfShares: Int? = nil, numOfSubs: Int? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self.privacyType = privacyType
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
    public let privacyType:PrivacyType
    public var title: String
    public var description: String
    public var owner: String?
    public var members: [String?]?
    public var commits:[String?]?
    public var numOfLikes: Int?
    public var numOfDislikes: Int?
    public var numOfComments: Int?
    public var numOfShares: Int?
    public var numOfSubs: Int?
    public var createdAt: Date?
    public var updatedAt: Date?
}
