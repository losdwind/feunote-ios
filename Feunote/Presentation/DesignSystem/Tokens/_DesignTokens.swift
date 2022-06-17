//
//  DesignTokens.swift
//  Feunote
//
//  Created by Losd wind on 2022/5/14.
//

import SwiftUI
/*

// MARK: - Typography
// usage example
//    VStack {
//        Text("SwiftUI")
//            .font(.appTitle)
//        Text("It is awesome!")
//            .font(.appCaption)
//    }
extension Font {
    static func appFont(size: CGFloat) -> Font {
        return Font.custom("SF Pro", size: size)
    }
    
    static let appTitle = appFont(size: 32).weight(.semibold)
    static let appBody = appFont(size: 20).weight(.medium)
    static let appCaption = appFont(size: 14).weight(.regular)
}
 



// MARK: - Color

// use case
//Button("Tap Me", action: {})
//           .font(buttonFont)
//           .padding(8)
//           .foregroundColor(Color.Button.label)
//           .background(Color.appBlue)
//           .cornerRadius(10)
//           .overlay(
//               RoundedRectangle(cornerRadius: 10)
//                   .stroke(Color.Button.border, lineWidth: 2)
//           }

extension Color {
    static let appBlue = Color("appBlue")
 
    enum Button {
        static let label = Color("buttonLabel")
        static let border = Color("buttonBorder")
    }
}



// MARK: - Animation

// use case
//Button("Tap me", action: {})
//           .font(buttonFont)
//           .offset(x: moved ? 15 : -15)
//           .animation(Animation.offsetSpring.repeatForever(autoreverses: true))
//           .onAppear {
//               moved = true
//           }

struct AnimDuration {
    static let fast: Double = 0.1
    static let regular: Double = 0.3
    static let slow: Double = 0.5
}
 
extension Animation {
    static let easeInOutRegular = Self.easeInOut(duration: AnimDuration.regular)
    static let customCurve = Self.timingCurve(0, 0.8, 0.2, 1,
                                            duration: AnimDuration.slow)
    static let offsetSpring = Self.interpolatingSpring(
                                            mass: 0.05,
                                             stiffness: 4.5,
                                             damping: 0.8,
                                             initialVelocity: 5)
}
 




*/
