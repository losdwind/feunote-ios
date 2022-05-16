//
//  Button.swift
//  Feunote
//
//  Created by Losd wind on 2022/5/14.
//

import SwiftUI
struct EWButtonStyle: ButtonStyle {
    
//    let buttonFont = Font.custom("Zilla Slab", size: 20).weight(.bold)
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
//            .font(buttonFont)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .padding(.horizontal, 10)
            .foregroundColor(.white)
            .offset(y: -1)
            .frame(height: 30)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .opacity(configuration.isPressed ? 0.6 : 1)
            .animation(.spring())
    }
}
