//
//  WBScore.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/28.
//

import Foundation
struct WBScore:Identifiable, Codable{
    var id:String = UUID().uuidString
    var dateCreated: Date
    
    var career:Int = 0
    var social:Int = 0
    var physical:Int = 0
    var financial:Int = 0
    var community:Int = 0
    
    
}
