// swiftlint:disable all
import Amplify
import Foundation

extension AmplifyCommit {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case owner
    case commitType
    case order
    case titleOrName
    case description
    case photoKeys
    case audioKeys
    case videoKeys
    case toBranch
    case todoCompletion
    case todoReminder
    case todoStart
    case todoEnd
    case personPriority
    case personAddress
    case personBirthday
    case personContact
    case personAvatarKey
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let amplifyCommit = AmplifyCommit.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "AmplifyCommits"
    
    model.attributes(
      .index(fields: ["toBranchID", "order"], name: "byBranch")
    )
    
    model.fields(
      .id(),
      .field(amplifyCommit.owner, is: .optional, ofType: .string),
      .field(amplifyCommit.commitType, is: .required, ofType: .enum(type: CommitType.self)),
      .field(amplifyCommit.order, is: .required, ofType: .double),
      .field(amplifyCommit.titleOrName, is: .optional, ofType: .string),
      .field(amplifyCommit.description, is: .optional, ofType: .string),
      .field(amplifyCommit.photoKeys, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(amplifyCommit.audioKeys, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(amplifyCommit.videoKeys, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .belongsTo(amplifyCommit.toBranch, is: .optional, ofType: AmplifyBranch.self, targetName: "toBranchID"),
      .field(amplifyCommit.todoCompletion, is: .optional, ofType: .bool),
      .field(amplifyCommit.todoReminder, is: .optional, ofType: .bool),
      .field(amplifyCommit.todoStart, is: .optional, ofType: .dateTime),
      .field(amplifyCommit.todoEnd, is: .optional, ofType: .dateTime),
      .field(amplifyCommit.personPriority, is: .optional, ofType: .int),
      .field(amplifyCommit.personAddress, is: .optional, ofType: .string),
      .field(amplifyCommit.personBirthday, is: .optional, ofType: .date),
      .field(amplifyCommit.personContact, is: .optional, ofType: .string),
      .field(amplifyCommit.personAvatarKey, is: .optional, ofType: .string),
      .field(amplifyCommit.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(amplifyCommit.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}