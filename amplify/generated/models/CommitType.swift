// swiftlint:disable all
import Amplify
import Foundation

public enum CommitType: String, EnumPersistable, CaseIterable {
  case moment = "MOMENT"
  case todo = "TODO"
  case person = "PERSON"
}
