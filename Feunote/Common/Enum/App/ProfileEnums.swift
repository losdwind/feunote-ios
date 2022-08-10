//
//  ProfileEnums.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/24.
//

import Foundation

enum SocialMediaCategory: String, CaseIterable {
    case facebook
    case instagram
    case linkedin
    case paypal
    case pinterest
    case skype
    case spotify
    case twitter
    case youtube
}

enum Marriage: String, CaseIterable {
    case single
    case married
    case divorced
    case separated
    case spouseDeceased
}

enum Income: String, CaseIterable {
    case single
    case married
    case divorced
    case separated
    case spouseDeceased
}

struct UserPrivate: Identifiable, Codable, Hashable {
    // can be retreive from the Auth.auth().currentUser : uid, email. photoURL
    var id: String = UUID().uuidString
    var email: String?

    var profileImageURL: String?
    var nickName: String? // first name, family name
    var dateCreated: Date

    var bio: String?

    var realName: String?
    var gender: String?
    var birthday: Date
    var address: String?
    var mobile: String?
    var job: String?
    var income: String?
    var marriage: String?

    var socialMedia: [String: String]? // phone, facebook, twitter, wechat

    var interest: [String]? // fishing, gaming
    var bigFive: [String: Int]? // O C E A N
    var WBIndex: [String: Int]? // career, health, emotion, finance, community
    var trajectories: String? // save in google storage
    var misc: String?
}
