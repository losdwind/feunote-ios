// swiftlint:disable all
import Amplify
import Foundation

extension AmplifyBranch {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case owner
    case privacyType
    case title
    case description
    case squadName
    case commits
    case actions
    case messages
    case comments
    case numOfLikes
    case numOfDislikes
    case numOfComments
    case numOfShares
    case numOfSubs
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let amplifyBranch = AmplifyBranch.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read]),
      rule(allow: .private, operations: [.read, .update])
    ]
    
    model.pluralName = "AmplifyBranches"
    
    model.fields(
      .id(),
      .field(amplifyBranch.owner, is: .optional, ofType: .string),
      .field(amplifyBranch.privacyType, is: .required, ofType: .enum(type: PrivacyType.self)),
      .field(amplifyBranch.title, is: .required, ofType: .string),
      .field(amplifyBranch.description, is: .required, ofType: .string),
      .field(amplifyBranch.squadName, is: .optional, ofType: .string),
      .hasMany(amplifyBranch.commits, is: .optional, ofType: AmplifyCommit.self, associatedWith: AmplifyCommit.keys.toBranch),
      .hasMany(amplifyBranch.actions, is: .optional, ofType: AmplifyAction.self, associatedWith: AmplifyAction.keys.toBranch),
      .hasMany(amplifyBranch.messages, is: .optional, ofType: AmplifyMessage.self, associatedWith: AmplifyMessage.keys.toBranch),
      .hasMany(amplifyBranch.comments, is: .optional, ofType: AmplifyComment.self, associatedWith: AmplifyComment.keys.toBranch),
      .field(amplifyBranch.numOfLikes, is: .optional, ofType: .int),
      .field(amplifyBranch.numOfDislikes, is: .optional, ofType: .int),
      .field(amplifyBranch.numOfComments, is: .optional, ofType: .int),
      .field(amplifyBranch.numOfShares, is: .optional, ofType: .int),
      .field(amplifyBranch.numOfSubs, is: .optional, ofType: .int),
      .field(amplifyBranch.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(amplifyBranch.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}