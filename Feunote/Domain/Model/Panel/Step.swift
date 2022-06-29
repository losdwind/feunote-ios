//
//  Step.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/24.
//

import Foundation
struct Step: Identifiable, Codable {
    var id:String = UUID().uuidString
    var count: Int = 0
    var localTimestamp: Date = Date()
}

