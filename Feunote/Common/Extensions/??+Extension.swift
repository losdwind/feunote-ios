
//  Optional+Extension.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/23.


//import Foundation
//extension Optional where Wrapped == String {
//    var _bound: String? {
//        get {
//            return self
//        }
//        set {
//            self = newValue
//        }
//    }
//
//
//    public var bound: String {
//        get {
//            return _bound ?? ""
//        }
//        set {
//            _bound = newValue.isEmpty ? nil : newValue
//        }
//    }
//}
//
//
//extension Optional where Wrapped == Date {
//    var _bound: Date? {
//        get {
//            return self
//        }
//        set {
//            self = newValue
//        }
//    }
//    public var bound: Date {
//        get {
//            return _bound ?? Date.now
//        }
//        set {
//            _bound = newValue == Date.now ? nil : newValue
//        }
//    }
//}

import SwiftUI
func ??<T:Equatable>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue =  (lhs.wrappedValue == rhs) ? nil : $0 }
    )
}

func ??<T:Equatable>(lhs: Binding<T>, rhs: T) -> Binding<T> {
    return lhs
}
