//
//  BranchEnum.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import Foundation
import UIKit
enum CategoryOfBranch:String,CaseIterable, Codable {
    case Creation
    case Competetion
    case Startup
    case Discussion
    case Perfection
    case Idol
    case Hobby
    case Game
    case Study
}


enum CategoryofPopularity:String,CaseIterable, Codable {
    case Popular
    case Recent
    case Subscribed    
}

enum CommunityTab: String,CaseIterable, Codable {
    case Hot
    case Sub
    case Local
}
