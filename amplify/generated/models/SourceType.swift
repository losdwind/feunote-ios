// swiftlint:disable all
import Amplify
import Foundation

public enum SourceType: String, EnumPersistable {
  case gps = "GPS"
  case steps = "STEPS"
  case emotion = "EMOTION"
  case sleep = "SLEEP"
  case meditation = "MEDITATION"
  case survey = "SURVEY"
}