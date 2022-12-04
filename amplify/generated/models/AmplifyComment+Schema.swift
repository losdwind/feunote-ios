// swiftlint:disable all
import Amplify
import Foundation

extension AmplifyComment {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case owner
    case creator
    case toBranch
    case content
    case timestamp
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let amplifyComment = AmplifyComment.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read]),
      rule(allow: .private, operations: [.read])
    ]
    
    model.pluralName = "AmplifyComments"
    
    model.attributes(
      .index(fields: ["creatorID", "timestamp"], name: "byCreator"),
      .index(fields: ["toBranchID", "timestamp"], name: "byBranch")
    )
    
    model.fields(
      .id(),
      .field(amplifyComment.owner, is: .optional, ofType: .string),
      .belongsTo(amplifyComment.creator, is: .required, ofType: AmplifyUser.self, targetName: "creatorID"),
      .belongsTo(amplifyComment.toBranch, is: .required, ofType: AmplifyBranch.self, targetName: "toBranchID"),
      .field(amplifyComment.content, is: .required, ofType: .string),
      .field(amplifyComment.timestamp, is: .optional, ofType: .dateTime),
      .field(amplifyComment.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(amplifyComment.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}