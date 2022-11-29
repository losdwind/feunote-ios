// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "4800a5af0e9e623d7062a0e803dcc3bb"
  
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