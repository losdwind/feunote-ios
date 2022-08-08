// swiftlint:disable all
import Amplify
import Foundation

public struct AmplifyBranch: Model {
  public let id: String
  public var owner: String?
  public var privacyType: PrivacyType
  public var title: String
  public var description: String
  public var squadName: String?
  public var commits: List<AmplifyCommit>?
  public var actions: List<AmplifyAction>?
  public var numOfLikes: Int?
  public var numOfDislikes: Int?
  public var numOfComments: Int?
  public var numOfShares: Int?
  public var numOfSubs: Int?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      owner: String? = nil,
      privacyType: PrivacyType,
      title: String,
      description: String,
      squadName: String? = nil,
      commits: List<AmplifyCommit>? = [],
      actions: List<AmplifyAction>? = [],
      numOfLikes: Int? = nil,
      numOfDislikes: Int? = nil,
      numOfComments: Int? = nil,
      numOfShares: Int? = nil,
      numOfSubs: Int? = nil) {
    self.init(id: id,
      owner: owner,
      privacyType: privacyType,
      title: title,
      description: description,
      squadName: squadName,
      commits: commits,
      actions: actions,
      numOfLikes: numOfLikes,
      numOfDislikes: numOfDislikes,
      numOfComments: numOfComments,
      numOfShares: numOfShares,
      numOfSubs: numOfSubs,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      owner: String? = nil,
      privacyType: PrivacyType,
      title: String,
      description: String,
      squadName: String? = nil,
      commits: List<AmplifyCommit>? = [],
      actions: List<AmplifyAction>? = [],
      numOfLikes: Int? = nil,
      numOfDislikes: Int? = nil,
      numOfComments: Int? = nil,
      numOfShares: Int? = nil,
      numOfSubs: Int? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.owner = owner
      self.privacyType = privacyType
      self.title = title
      self.description = description
      self.squadName = squadName
      self.commits = commits
      self.actions = actions
      self.numOfLikes = numOfLikes
      self.numOfDislikes = numOfDislikes
      self.numOfComments = numOfComments
      self.numOfShares = numOfShares
      self.numOfSubs = numOfSubs
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}