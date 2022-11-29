// swiftlint:disable all
import Amplify
import Foundation

extension AmplifyUser {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case owner
    case nickName
    case username
    case avatarKey
    case bio
    case email
    case realName
    case gender
    case birthday
    case address
    case phone
    case job
    case income
    case marriage
    case socialMedia
    case interest
    case bigFive
    case wellbeingIndex
    case actions
    case messages
    case comments
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let amplifyUser = AmplifyUser.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "AmplifyUsers"
    
    model.fields(
      .id(),
      .field(amplifyUser.owner, is: .optional, ofType: .string),
      .field(amplifyUser.nickName, is: .optional, ofType: .string),
      .field(amplifyUser.username, is: .optional, ofType: .string),
      .field(amplifyUser.avatarKey, is: .optional, ofType: .string),
      .field(amplifyUser.bio, is: .optional, ofType: .string),
      .field(amplifyUser.email, is: .optional, ofType: .string),
      .field(amplifyUser.realName, is: .optional, ofType: .string),
      .field(amplifyUser.gender, is: .optional, ofType: .string),
      .field(amplifyUser.birthday, is: .optional, ofType: .date),
      .field(amplifyUser.address, is: .optional, ofType: .string),
      .field(amplifyUser.phone, is: .optional, ofType: .string),
      .field(amplifyUser.job, is: .optional, ofType: .string),
      .field(amplifyUser.income, is: .optional, ofType: .string),
      .field(amplifyUser.marriage, is: .optional, ofType: .string),
      .field(amplifyUser.socialMedia, is: .optional, ofType: .string),
      .field(amplifyUser.interest, is: .optional, ofType: .string),
      .field(amplifyUser.bigFive, is: .optional, ofType: .string),
      .field(amplifyUser.wellbeingIndex, is: .optional, ofType: .string),
      .hasMany(amplifyUser.actions, is: .optional, ofType: AmplifyAction.self, associatedWith: AmplifyAction.keys.creator),
      .hasMany(amplifyUser.messages, is: .optional, ofType: AmplifyMessage.self, associatedWith: AmplifyMessage.keys.creator),
      .hasMany(amplifyUser.comments, is: .optional, ofType: AmplifyComment.self, associatedWith: AmplifyComment.keys.creator),
      .field(amplifyUser.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(amplifyUser.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}