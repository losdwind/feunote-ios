//
//  FeuUser.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/26.
//

import Foundation
import SwiftUI
public struct FeuUser: Hashable,Identifiable {
    public static func == (lhs: FeuUser, rhs: FeuUser) -> Bool {
        return lhs.email == rhs.email
    }
    
    public let id: String = UUID().uuidString
    public var email: String
    public var avatarImage: UIImage
    public var nickName: String
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
  
