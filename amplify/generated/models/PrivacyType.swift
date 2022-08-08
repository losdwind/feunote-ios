// swiftlint:disable all
import Amplify
import Foundation

public enum PrivacyType: String, EnumPersistable, CaseIterable {
  case open = "OPEN"
  case `private` = "PRIVATE"
  case limited = "LIMITED"
}
