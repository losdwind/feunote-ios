//
//  Commit.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/26.
//

import Foundation
import SwiftUI

public struct FeuCommit: Hashable,Identifiable {
  public let id: String = UUID().uuidString
  public var commitType: CommitType
  public var owner: FeuUser
  public var titleOrName: String?
  public var description: String?
  public var photos: [UIImage]?
  public var audios: [NSData]?
  public var videos: [NSData]?
  public var toBranch: FeuBranch?
  public var momentWordCount: Int?
  public var todoCompletion: Bool?
  public var todoReminder: Bool?
  public var todoStart: Date?
  public var todoEnd: Date?
  public var personPriority: Int?
  public var personAddress: String?
  public var personBirthday: Date?
  public var personContact: String?
  public var personAvatar: UIImage?
  public var createdAt: Date?
  public var updatedAt: Date?
}
