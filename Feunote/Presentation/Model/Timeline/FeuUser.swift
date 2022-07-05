//
//  FeuUser.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/26.
//

import Foundation
import SwiftUI
public struct FeuUser: Hashable,Identifiable {
    internal init(username: String, email: String? = nil, avatarImage: UIImage? = nil, nickName: String? = nil, bio: String? = nil, realName: String? = nil, gender: String? = nil, birthday: Date? = nil, address: String? = nil, phone: String? = nil, job: String? = nil, income: String? = nil, marriage: String? = nil, socialMedia: String? = nil, interest: [String]? = nil, bigFive: String? = nil, wellbeingIndex: String? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.username = username
        self.email = email
        self.avatarImage = avatarImage
        self.nickName = nickName
        self.bio = bio
        self.realName = realName
        self.gender = gender
        self.birthday = birthday
        self.address = address
        self.phone = phone
        self.job = job
        self.income = income
        self.marriage = marriage
        self.socialMedia = socialMedia
        self.interest = interest
        self.bigFive = bigFive
        self.wellbeingIndex = wellbeingIndex
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    public init(){
        self.init(username:"")
    }
    
    
    public let id: String = UUID().uuidString
    public let username:String
    public var email: String?
    public var avatarImage: UIImage?
    public var nickName: String?
    public var bio: String?
    //    public var commits: [AmplifyCommit]?
    //    public var branches: [AmplifyBranch]?
    //    public var givenActions: [FeuAction]?
    //    public var userSenorData: [FeuSensor]?
    public var realName: String?
    public var gender: String?
    public var birthday: Date?
    public var address: String?
    public var phone: String?
    public var job: String?
    public var income: String?
    public var marriage: String?
    public var socialMedia: String?
    public var interest: [String]?
    public var bigFive: String?
    public var wellbeingIndex: String?
    public var createdAt: Date?
    public var updatedAt: Date?
}

