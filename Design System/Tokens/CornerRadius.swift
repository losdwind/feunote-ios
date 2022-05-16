//
//  RoundedCorner.swift
//  BricksUI
//
//  Created by Micaela Cavallo on 01/05/2020.
//  Copyright © 2020 Fabio Staiano. All rights reserved.
//

import SwiftUI

//enum EWCorner {
//    case small, large, rounded
//}
//
//extension View {
//    // function for CornerRadius struct
//    func cornerRadius(size:EWCorner) -> some View {
//
//        switch size {
//        case .small: return clipShape( RoundedCorner(radius: 4, corners: .allCorners) )
//        case .large: return clipShape( RoundedCorner(radius: 8, corners: .allCorners) )
//
//        case .rounded:
//            return clipShape( RoundedCorner(radius: .infinity, corners: .allCorners) )
//        }
//
//    }
//}
//
///// Custom shape with independently rounded corners
//struct RoundedCorner: Shape {
//
//    var radius: CGFloat = .infinity
//    var corners: UIRectCorner = .allCorners
//
//    func path(in rect: CGRect) -> Path {
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        return Path(path.cgPath)
//    }
//}



extension CGFloat {
    static let ewCornerRadiusSmall = 4
    static let ewCornerRadiusNormal = 8
    static let ewCornerRadiusLarge = 16
    static let ewCornerRadiusRound = CGFloat.infinity
}
