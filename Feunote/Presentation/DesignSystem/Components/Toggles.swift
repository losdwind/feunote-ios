//
//  Toggles.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import SwiftUI

struct ColoredToggleStyle: ToggleStyle {
    var onColor = Color.ewSecondaryBase
    var offColor = Color.ewGray100
    var thumbColor = Color.white
    var offIconName = ""
    var onIconName = "checkmark"

    func makeBody(configuration: Self.Configuration) -> some View {
        withAnimation(.easeInOut(duration: 0.1)) {
            Button(action: { configuration.isOn.toggle() }) {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 50, height: 29)
                    .overlay(
                        ZStack {
                            Circle()
                                .fill(thumbColor)
                                .shadow(radius: 1, x: 0, y: 1)
                                .padding(1.5)
                                .offset(x: configuration.isOn ? 10 : -10)
                            Image(systemName: configuration.isOn ? onIconName : offIconName)
                                .font(.system(size: 12, weight: .black))
                                .foregroundColor(onColor)
                                .offset(x: configuration.isOn ? 10 : -10)
                        }
                    )
            }
            .font(.title)
        }
    }
}

public struct EWToggle: View {

    @Binding var toggleState: Bool
    var title:String



    public var body: some View {
        Toggle(title, isOn: $toggleState)
            .toggleStyle(
                ColoredToggleStyle(
                    onColor: .ewSecondaryBase,
                    offColor: .ewGray100,
                    thumbColor: .white,
                    offIconName: "", onIconName: "checkmark"
                ))
    }
}

struct Toggles_Previews: PreviewProvider {
    @State static var toggleState = false
    static var previews: some View {
        VStack {
            EWToggle(toggleState: $toggleState, title: "Good")
        }
    }
}
