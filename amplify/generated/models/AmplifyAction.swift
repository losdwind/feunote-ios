// swiftlint:disable all
import Amplify
import Foundation

public struct AmplifyAction: Model {
  public let id: String
  public var owner: String?
  public var creator: AmplifyUser
  public var toBranch: AmplifyBranch
  public var actionType: String
  public var content: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      owner: String? = nil,
      creator: AmplifyUser,
      toBranch: AmplifyBranch,
      actionType: ActionType,
      content: String? = nil) {
    self.init(id: id,
      owner: owner,
      creator: creator,
      toBranch: toBranch,
              actionType: actionType.rawValue,
      content: content,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      owner: String? = nil,
      creator: AmplifyUser,
      toBranch: AmplifyBranch,
      actionType: String,
      content: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.owner = owner
      self.creator = creator
      self.toBranch = toBranch
      self.actionType = actionType
      self.content = content
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}
