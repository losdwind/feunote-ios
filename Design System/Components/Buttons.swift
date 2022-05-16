//
//  Buttons.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import SwiftUI

// MARK: - Custom Button Styles

struct EWButtonStyle: ButtonStyle {
    var color: Color
    var style: EWButton.Style
    
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        switch style {
        case .fill: return AnyView(FillButton(color: color, configuration: configuration))
        case .outline: return AnyView(OutlineButton(color: color, configuration: configuration))
        case .ghost: return AnyView(GhostButton(color: color, configuration: configuration))
        }
    }
    
    struct FillButton: View {
        var color: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .font(.ewHeadline)
                .foregroundColor(isEnabled ? .white : .ewFontDisabled)
                .padding()
                .frame(minHeight: 56)
                .background(isEnabled ? color : Color.ewBasic.opacity(0.2))
                .cornerRadius(4)
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }
    
    struct OutlineButton: View {
        var color: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .font(.ewHeadline)
                .foregroundColor(isEnabled ? color : .ewGray50)
                .padding()
                .frame(minHeight: 56)
                .background(isEnabled ? color.opacity(0.2) : Color.ewBasic.opacity(0.15))
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(isEnabled ? color : Color.ewBasic.opacity(0.5), lineWidth: 1)
                )
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }
    
    struct GhostButton: View {
        var color: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .ewTypo(.s1)
                .foregroundColor(isEnabled ? color : .ewFontDisabled)
                .padding()
                .frame(minHeight: 56)
                .background(Color.white)
                .cornerRadius(4)
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }
}

// MARK: - Usage

extension Button {
    /// Changes the appearance of the button
    func style(_ style: EWButton.Style, color: Color) -> some View {
        self.buttonStyle(EWButtonStyle(color: color, style: style))
    }
}

struct EWButton: View {
    
    enum Style {
        case fill, outline, ghost
    }
    
    var text: String?
    var image: Image?
    var style: Style = .fill
    var color: Color = .ewPrimary
    var action: () -> Void
    var textAndImage: Bool { text != nil && image != nil }
    
    var body: some View {
        Button(action: action, label: {
            HStack() {
                Spacer()
                HStack(spacing: textAndImage ? 12 : 0) {
                    Text(text ?? "")
                    image
                }
                Spacer()
            }
        }).style(style, color: color)
    }
}


// MARK: - Preview

public struct Input_Previews: PreviewProvider {
    static let cloudImg = Image(systemName: "cloud.sun")
    
    public static var previews: some View {
        VStack(spacing: 40) {
            
            HStack(spacing: 5) {
                EWButton(text: "Fill", style: .fill, action: { print("click") })
                EWButton(text: "Outline", style: .outline, action: { print("click") })
                EWButton(text: "Ghost", style: .ghost, action: { print("click") })
            }
            
            HStack(spacing: 5) {
                EWButton(text: "Danger", color: .ewDanger, action: { print("click") })
                EWButton(text: "Warning", color: .ewWarning, action: { print("click") })
                EWButton(text: "Success", color: .ewSuccess, action: { print("click") })
            }
            
            HStack(spacing: 5) {
                EWButton(text: "Disabled", style: .fill, action: { print("click") })
                    .disabled(true)
                EWButton(text: "Disabled", style: .outline, action: { print("click") })
                    .disabled(true)
                EWButton(text: "Disabled", style: .ghost, action: { print("click") })
                    .disabled(true)
            }
            
            HStack(spacing: 5) {
                EWButton(text: "Text", action: { print("click") })
                EWButton(text: "Text", image: cloudImg, action: { print("click") })
                EWButton(image: cloudImg, action: { print("click") })
            }
            
            Button(action: { print("click") }, label: { Text("Custom") })
                .style(.outline, color: .ewFontBtn)
        }
    .padding(10)
    }
}
