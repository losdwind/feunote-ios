//
//  RadioButton.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import SwiftUI

public struct EWRadioButton: View {
    var isChecked: Bool
    var color: Color?
    var text: String = ""
    
    private var colorToUse: Color? { isEnabled ? color : .ewGray100 }
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    public var body: some View {
        HStack(spacing: text.isEmpty ? 0 : 6) {
            isChecked ? AnyView(CheckedButton(color: colorToUse ?? .ewPrimaryBase)) : AnyView(UncheckedButton(color: colorToUse ?? .ewGray100))
            Text(text)
        }
    }
}

private struct CheckedButton: View {
    var color: Color = .ewPrimaryBase
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: 20, height: 20)
            Circle()
                .fill(Color.white)
                .frame(width: 18, height: 18)
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
        }
    }
}

private struct UncheckedButton: View {
    var color: Color = .ewGray100
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: 20, height: 20)
            Circle()
                .fill(Color.white)
                .frame(width: 18, height: 18)
            Circle()
                .fill(color.opacity(0.1))
                .frame(width: 18, height: 18)
        }
    }
}


struct RadioButton_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack(alignment: .leading, spacing: 12) {
            EWRadioButton(isChecked: true)
            EWRadioButton(isChecked: false)
            EWRadioButton(isChecked: true).disabled(true)
            EWRadioButton(isChecked: false).disabled(true)

            EWRadioButton(isChecked: true, text: "Text")
            EWRadioButton(isChecked: true, color: .ewWarning, text: "Text and custom color")
        }
    }
}
