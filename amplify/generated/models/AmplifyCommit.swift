// swiftlint:disable all
import Amplify
import Foundation

public struct AmplifyCommit: Model {
  public let id: String
  public var owner: String?
  public var commitType: CommitType
  public var order: Double?
  public var titleOrName: String?
  public var description: String?
  public var photoKeys: [String?]?
  public var audioKeys: [String?]?
  public var videoKeys: [String?]?
  public var toBranch: AmplifyBranch?
  public var momentWordCount: Int?
  public var todoCompletion: Bool?
  public var todoReminder: Bool?
  public var todoStart: Temporal.DateTime?
  public var todoEnd: Temporal.DateTime?
  public var personPriority: Int?
  public var personAddress: String?
  public var personBirthday: Temporal.Date?
  public var personContact: String?
  public var personAvatarKey: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      owner: String? = nil,
      commitType: CommitType,
      order: Double? = nil,
      titleOrName: String? = nil,
      description: String? = nil,
      photoKeys: [String?]? = nil,
      audioKeys: [String?]? = nil,
      videoKeys: [String?]? = nil,
      toBranch: AmplifyBranch? = nil,
      momentWordCount: Int? = nil,
      todoCompletion: Bool? = nil,
      todoReminder: Bool? = nil,
      todoStart: Temporal.DateTime? = nil,
      todoEnd: Temporal.DateTime? = nil,
      personPriority: Int? = nil,
      personAddress: String? = nil,
      personBirthday: Temporal.Date? = nil,
      personContact: String? = nil,
      personAvatarKey: String? = nil) {
    self.init(id: id,
      owner: owner,
      commitType: commitType,
      order: order,
      titleOrName: titleOrName,
      description: description,
      photoKeys: photoKeys,
      audioKeys: audioKeys,
      videoKeys: videoKeys,
      toBranch: toBranch,
      momentWordCount: momentWordCount,
      todoCompletion: todoCompletion,
      todoReminder: todoReminder,
      todoStart: todoStart,
      todoEnd: todoEnd,
      personPriority: personPriority,
      personAddress: personAddress,
      personBirthday: personBirthday,
      personContact: personContact,
      personAvatarKey: personAvatarKey,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      owner: String? = nil,
      commitType: CommitType,
      order: Double? = nil,
      titleOrName: String? = nil,
      description: String? = nil,
      photoKeys: [String?]? = nil,
      audioKeys: [String?]? = nil,
      videoKeys: [String?]? = nil,
      toBranch: AmplifyBranch? = nil,
      momentWordCount: Int? = nil,
      todoCompletion: Bool? = nil,
      todoReminder: Bool? = nil,
      todoStart: Temporal.DateTime? = nil,
      todoEnd: Temporal.DateTime? = nil,
      personPriority: Int? = nil,
      personAddress: String? = nil,
      personBirthday: Temporal.Date? = nil,
      personContact: String? = nil,
      personAvatarKey: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.owner = owner
      self.commitType = commitType
      self.order = order
      self.titleOrName = titleOrName
      self.description = description
      self.photoKeys = photoKeys
      self.audioKeys = audioKeys
      self.videoKeys = videoKeys
      self.toBranch = toBranch
      self.momentWordCount = momentWordCount
      self.todoCompletion = todoCompletion
      self.todoReminder = todoReminder
      self.todoStart = todoStart
      self.todoEnd = todoEnd
      self.personPriority = personPriority
      self.personAddress = personAddress
      self.personBirthday = personBirthday
      self.personContact = personContact
      self.personAvatarKey = personAvatarKey
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}