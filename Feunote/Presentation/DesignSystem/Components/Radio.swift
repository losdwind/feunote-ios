//
//  RadioButton.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import SwiftUI

public struct EWRadio: View {
    @Binding var isChecked: Bool
    var color: Color?
    var text: String?
    
    private var colorToUse: Color? { isEnabled ? color : .ewGray100 }
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    public var body: some View {
        
        HStack(spacing: .ewPaddingHorizontalLarge) {
            Button {
                isChecked.toggle()
            } label: {
                isChecked ? AnyView(CheckedButton(color: colorToUse ?? .ewPrimaryBase)) : AnyView(UncheckedButton(color: colorToUse ?? .ewGray100))
            }
            if(text != nil){
                Text(text!)
                    .foregroundColor(colorToUse ?? .ewPrimaryBase)
            }

            
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
    
    @State static var isChecked = true
    
    static var previews: some View {
        VStack(alignment: .leading, spacing: 12) {
            EWRadio(isChecked: $isChecked)
            EWRadio(isChecked: $isChecked).disabled(true)

            EWRadio(isChecked: $isChecked, text: "Text")
            EWRadio(isChecked: $isChecked, color: .ewWarning, text: "Text and custom color")
        }
    }
}