//
//  FeuAction.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/26.
//

import Foundation
public struct FeuAction: Hashable,Identifiable {
    public let id: String = UUID().uuidString
    public var owner: String
    public var toBranch: String
    public var actionType: ActionType
    public var content: String?
    public var createdAt: Date?
    public var updatedAt: Date?
}
