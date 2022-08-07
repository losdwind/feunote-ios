//
//  HapticFeedback.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/6.
//

import Foundation
import SwiftUI
class HapticFeedback {
#if os(watchOS)
    //watchOS implementation
    static func playSelection() -> Void {
        WKInterfaceDevice.current().play(.click)
    }
#elseif os(iOS)
    //iOS implementation
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    static func playSelection() -> Void {
        UISelectionFeedbackGenerator().selectionChanged()
    }
#else
    static func playSelection() -> Void {
        //No-op
    }
#endif
}
