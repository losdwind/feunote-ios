//
//  Location.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/27.
//

import Foundation

struct Place: Identifiable, Codable {
    var id:String = UUID().uuidString
    var dateCreated:Date
    var geohash:String = ""
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var locality: String = ""
    var administrationArea:String = ""
    var country:String = ""
}
