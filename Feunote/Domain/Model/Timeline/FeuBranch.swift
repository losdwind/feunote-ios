//
//  FeuBranch.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/26.
//

import Foundation
public struct FeuBranch:Identifiable,Hashable {
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
