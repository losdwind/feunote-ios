//
//  Toggles.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import SwiftUI

public struct EWCheckbox: View {
    enum Style {
        case defaultStyle, primary
    }

    @State var checkboxState: Bool = true
    var style: Style

    struct ColoredCheckboxStyle: ToggleStyle {
        var onColor = Color.ewPrimaryBase
        var offColor = Color.ewGray100

        func makeBody(configuration: Self.Configuration) -> some View {
            return HStack {
                configuration.label
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .onTapGesture { configuration.isOn.toggle() }
                    .foregroundColor(configuration.isOn ? onColor : offColor)
            }
        }
    }

    public var body: some View {
        switch style {
        case .primary: return AnyView(primary())

        case .defaultStyle: return AnyView(defaultStyle())
        }
    }

    fileprivate func defaultStyle() -> some View {
        Toggle("", isOn: $checkboxState)
            .toggleStyle(ColoredCheckboxStyle(onColor: .ewSecondaryBase, offColor: .ewGray100))
    }

    fileprivate func primary() -> some View {
        Toggle("", isOn: $checkboxState)
            .toggleStyle(ColoredCheckboxStyle(onColor: .ewPrimaryBase, offColor: .ewGray100))
    }
}

struct Checkboxes_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            EWCheckbox(checkboxState: true, style: .defaultStyle)
            EWCheckbox(checkboxState: true, style: .primary)
        }
    }
}
