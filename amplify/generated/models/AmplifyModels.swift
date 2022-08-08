// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "a6f354d30467ea55c5bc9d28025bce53"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: AmplifyUser.self)
    ModelRegistry.register(modelType: AmplifyAction.self)
    ModelRegistry.register(modelType: AmplifyBranch.self)
    ModelRegistry.register(modelType: AmplifyCommit.self)
    ModelRegistry.register(modelType: AmplifySensor.self)
  }
}