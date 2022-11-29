// swiftlint:disable all
import Amplify
import Foundation

public struct AmplifyUser: Model {
  public let id: String
  public var owner: String?
  public var nickName: String?
  public var username: String?
  public var avatarKey: String?
  public var bio: String?
  public var email: String?
  public var realName: String?
  public var gender: String?
  public var birthday: Temporal.Date?
  public var address: String?
  public var phone: String?
  public var job: String?
  public var income: String?
  public var marriage: String?
  public var socialMedia: String?
  public var interest: String?
  public var bigFive: String?
  public var wellbeingIndex: String?
  public var actions: List<AmplifyAction>?
  public var messages: List<AmplifyMessage>?
  public var comments: List<AmplifyComment>?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      owner: String? = nil,
      nickName: String? = nil,
      username: String? = nil,
      avatarKey: String? = nil,
      bio: String? = nil,
      email: String? = nil,
      realName: String? = nil,
      gender: String? = nil,
      birthday: Temporal.Date? = nil,
      address: String? = nil,
      phone: String? = nil,
      job: String? = nil,
      income: String? = nil,
      marriage: String? = nil,
      socialMedia: String? = nil,
      interest: String? = nil,
      bigFive: String? = nil,
      wellbeingIndex: String? = nil,
      actions: List<AmplifyAction>? = [],
      messages: List<AmplifyMessage>? = [],
      comments: List<AmplifyComment>? = []) {
    self.init(id: id,
      owner: owner,
      nickName: nickName,
      username: username,
      avatarKey: avatarKey,
      bio: bio,
      email: email,
      realName: realName,
      gender: gender,
      birthday: birthday,
      address: address,
      phone: phone,
      job: job,
      income: income,
      marriage: marriage,
      socialMedia: socialMedia,
      interest: interest,
      bigFive: bigFive,
      wellbeingIndex: wellbeingIndex,
      actions: actions,
      messages: messages,
      comments: comments,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      owner: String? = nil,
      nickName: String? = nil,
      username: String? = nil,
      avatarKey: String? = nil,
      bio: String? = nil,
      email: String? = nil,
      realName: String? = nil,
      gender: String? = nil,
      birthday: Temporal.Date? = nil,
      address: String? = nil,
      phone: String? = nil,
      job: String? = nil,
      income: String? = nil,
      marriage: String? = nil,
      socialMedia: String? = nil,
      interest: String? = nil,
      bigFive: String? = nil,
      wellbeingIndex: String? = nil,
      actions: List<AmplifyAction>? = [],
      messages: List<AmplifyMessage>? = [],
      comments: List<AmplifyComment>? = [],
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.owner = owner
      self.nickName = nickName
      self.username = username
      self.avatarKey = avatarKey
      self.bio = bio
      self.email = email
      self.realName = realName
      self.gender = gender
      self.birthday = birthday
      self.address = address
      self.phone = phone
      self.job = job
      self.income = income
      self.marriage = marriage
      self.socialMedia = socialMedia
      self.interest = interest
      self.bigFive = bigFive
      self.wellbeingIndex = wellbeingIndex
      self.actions = actions
      self.messages = messages
      self.comments = comments
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}