//
//  Typography.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import SwiftUI

extension Font {
    static let ewLargeTitle = Font.largeTitle
    static let ewTitle2 = Font.title2
    static let ewHeadline = Font.headline
    static let ewBody = Font.body
    static let ewSubheadline = Font.subheadline
    static let ewFootnote = Font.footnote
}

//
//
// public struct EWFont: ViewModifier {
//
//    enum Style {
//
//        case largeTitle
//        case title2
//        case headline
//        case body
//        case subheadline
//        case footnote
//    }
//
//    var style: Style
//
//    public func body(content: Content) -> some View {
//        switch style {
//        /// title
//        case .largeTitle: return content
//                .font(.largeTitle)
//        case .title2: return content
//                .font(.title2)
//        case .headline: return content
//                .font(.headline)
//        case .subheadline: return content
//                .font(.subheadline)
//        /// body
//        case .body: return content
//                .font(.body)
//
//        /// footnote
//        case .footnote: return content
//                .font(.footnote)
//        }
//    }
// }
//
// extension View {
//    func ewTypo(_ style: EWFont.Style) -> some View {
//        self
//            .modifier(EWFont(style: style))
//    }
//
//    func ewTypo(_ style: EWFont.Style, color: Color) -> some View {
//        self
//            .modifier(EWFont(style: style))
//            .foregroundColor(color)
//    }
// }
//
//
// struct Typography_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack(spacing: 10) {
//            Group {
//                Text("largeTitle").ewTypo(.largeTitle)
//                Text("title2").ewTypo(.title2)
//                Text("headline").ewTypo(.headline)
//                Text("subheadline").ewTypo(.subheadline, color: .ewPrimary500)
//                Text("body").ewTypo(.body)
//                Text("footnote").ewTypo(.footnote)
//                Text("footnote").ewTypo(.footnote, color: .ewSecondaryBase)
//
//            }
//
//            }
//        }
//    }
