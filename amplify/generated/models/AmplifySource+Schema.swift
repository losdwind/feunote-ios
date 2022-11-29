// swiftlint:disable all
import Amplify
import Foundation

extension AmplifySource {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case owner
    case creatorID
    case createAt
    case sourceType
    case sourceData
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let amplifySource = AmplifySource.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "AmplifySources"
    
    model.fields(
      .id(),
      .field(amplifySource.owner, is: .optional, ofType: .string),
      .field(amplifySource.creatorID, is: .optional, ofType: .string),
      .field(amplifySource.createAt, is: .optional, ofType: .dateTime),
      .field(amplifySource.sourceType, is: .required, ofType: .string),
      .field(amplifySource.sourceData, is: .optional, ofType: .string),
      .field(amplifySource.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(amplifySource.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}