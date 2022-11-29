// swiftlint:disable all
import Amplify
import Foundation

public struct AmplifyMessage: Model {
  public let id: String
  public var owner: String?
  public var creator: AmplifyUser
  public var toBranch: AmplifyBranch
  public var content: String?
  public var createAt: Temporal.DateTime?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      owner: String? = nil,
      creator: AmplifyUser,
      toBranch: AmplifyBranch,
      content: String? = nil,
      createAt: Temporal.DateTime? = nil) {
    self.init(id: id,
      owner: owner,
      creator: creator,
      toBranch: toBranch,
      content: content,
      createAt: createAt,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      owner: String? = nil,
      creator: AmplifyUser,
      toBranch: AmplifyBranch,
      content: String? = nil,
      createAt: Temporal.DateTime? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.owner = owner
      self.creator = creator
      self.toBranch = toBranch
      self.content = content
      self.createAt = createAt
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}