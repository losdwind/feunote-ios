// swiftlint:disable all
import Amplify
import Foundation

extension AmplifyMessage {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case owner
    case creator
    case toBranch
    case content
    case createAt
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let amplifyMessage = AmplifyMessage.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read]),
      rule(allow: .private, operations: [.read])
    ]
    
    model.pluralName = "AmplifyMessages"
    
    model.attributes(
      .index(fields: ["creatorID", "createAt"], name: "byCreator"),
      .index(fields: ["toBranchID", "createAt"], name: "byBranch")
    )
    
    model.fields(
      .id(),
      .field(amplifyMessage.owner, is: .optional, ofType: .string),
      .belongsTo(amplifyMessage.creator, is: .required, ofType: AmplifyUser.self, targetName: "creatorID"),
      .belongsTo(amplifyMessage.toBranch, is: .required, ofType: AmplifyBranch.self, targetName: "toBranchID"),
      .field(amplifyMessage.content, is: .optional, ofType: .string),
      .field(amplifyMessage.createAt, is: .optional, ofType: .dateTime),
      .field(amplifyMessage.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(amplifyMessage.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}