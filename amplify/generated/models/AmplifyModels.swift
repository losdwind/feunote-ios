// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "5afa9f9a26fe458dbf1f9bd12f10bd2e"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: AmplifyUser.self)
    ModelRegistry.register(modelType: AmplifyAction.self)
    ModelRegistry.register(modelType: AmplifyBranch.self)
    ModelRegistry.register(modelType: AmplifyCommit.self)
    ModelRegistry.register(modelType: AmplifyMessage.self)
    ModelRegistry.register(modelType: AmplifyComment.self)
    ModelRegistry.register(modelType: AmplifySource.self)
  }
}