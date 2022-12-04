// swiftlint:disable all
import Amplify
import Foundation

public enum ActionType: String, EnumPersistable {
  case sub = "SUB"
  case like = "LIKE"
  case dislike = "DISLIKE"
  case share = "SHARE"
  case participate = "PARTICIPATE"
}