// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "81c635a35e4f5eba88036e640477c0a3"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: AmplifyUser.self)
    ModelRegistry.register(modelType: AmplifyAction.self)
    ModelRegistry.register(modelType: AmplifyBranch.self)
    ModelRegistry.register(modelType: AmplifyCommit.self)
    ModelRegistry.register(modelType: AmplifySensor.self)
  }
}