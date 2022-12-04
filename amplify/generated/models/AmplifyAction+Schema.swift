// swiftlint:disable all
import Amplify
import Foundation

extension AmplifyAction {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case owner
    case creator
    case toBranch
    case actionType
    case content
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let amplifyAction = AmplifyAction.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read]),
      rule(allow: .private, operations: [.read])
    ]
    
    model.pluralName = "AmplifyActions"
    
    model.attributes(
      .index(fields: ["creatorID", "actionType"], name: "byCreator"),
      .index(fields: ["toBranchID", "actionType"], name: "byBranch")
    )
    
    model.fields(
      .id(),
      .field(amplifyAction.owner, is: .optional, ofType: .string),
      .belongsTo(amplifyAction.creator, is: .required, ofType: AmplifyUser.self, targetName: "creatorID"),
      .belongsTo(amplifyAction.toBranch, is: .required, ofType: AmplifyBranch.self, targetName: "toBranchID"),
      .field(amplifyAction.actionType, is: .required, ofType: .string),
      .field(amplifyAction.content, is: .optional, ofType: .string),
      .field(amplifyAction.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(amplifyAction.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}