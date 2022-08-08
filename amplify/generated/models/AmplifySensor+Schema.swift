// swiftlint:disable all
import Amplify
import Foundation

extension AmplifySensor {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case owner
    case trajectory
    case health
    case social
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let amplifySensor = AmplifySensor.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "AmplifySensors"
    
    model.fields(
      .id(),
      .field(amplifySensor.owner, is: .optional, ofType: .string),
      .field(amplifySensor.trajectory, is: .optional, ofType: .string),
      .field(amplifySensor.health, is: .optional, ofType: .string),
      .field(amplifySensor.social, is: .optional, ofType: .string),
      .field(amplifySensor.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(amplifySensor.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}