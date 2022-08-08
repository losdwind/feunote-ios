// swiftlint:disable all
import Amplify
import Foundation

public struct AmplifySensor: Model {
  public let id: String
  public var owner: String?
  public var trajectory: String?
  public var health: String?
  public var social: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      owner: String? = nil,
      trajectory: String? = nil,
      health: String? = nil,
      social: String? = nil) {
    self.init(id: id,
      owner: owner,
      trajectory: trajectory,
      health: health,
      social: social,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      owner: String? = nil,
      trajectory: String? = nil,
      health: String? = nil,
      social: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.owner = owner
      self.trajectory = trajectory
      self.health = health
      self.social = social
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}