//
//  WBScore.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/28.
//

import Foundation
struct WBScore: Identifiable, Codable {
    var id: String = UUID().uuidString
    var dateCreated: Date

    var fullScoreForEachComponent: Int = 200
    var career: Double = 0.5
    var social: Double = 0.5
    var physical: Double = 0.5
    var financial: Double = 0.5
    var community: Double = 0.5
}
