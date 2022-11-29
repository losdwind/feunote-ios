// swiftlint:disable all
import Amplify
import Foundation

public struct AmplifySource: Model {
  public let id: String
  public var owner: String?
  public var creatorID: String?
  public var createAt: Temporal.DateTime?
  public var sourceType: String
  public var sourceData: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      owner: String? = nil,
      creatorID: String? = nil,
      createAt: Temporal.DateTime? = nil,
      sourceType: String,
      sourceData: String? = nil) {
    self.init(id: id,
      owner: owner,
      creatorID: creatorID,
      createAt: createAt,
      sourceType: sourceType,
      sourceData: sourceData,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      owner: String? = nil,
      creatorID: String? = nil,
      createAt: Temporal.DateTime? = nil,
      sourceType: String,
      sourceData: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.owner = owner
      self.creatorID = creatorID
      self.createAt = createAt
      self.sourceType = sourceType
      self.sourceData = sourceData
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}