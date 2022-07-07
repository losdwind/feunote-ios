//
//  FeuSensorData.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/26.
//

import Foundation
public struct FeuSensor: Identifiable,Hashable {

    public let id: String = UUID().uuidString
    public var trajectory: String?
    public var health: String?
    public var social: String?
    public var owner: String?
    public var createdAt: Date?
    public var updatedAt: Date?
}

