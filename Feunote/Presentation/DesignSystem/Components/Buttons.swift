//
//  Buttons.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import SwiftUI

// MARK: - Custom Button Styles

struct EWButtonStyle: ButtonStyle {
    var style: EWButton.Style
    var color: Color
    
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        switch style {
        case .primaryLarge:
            return AnyView(PrimaryLargeButton(color: color, configuration: configuration))
        case .primarySmall:
            return AnyView(PrimarySmallButton(color: color, configuration: configuration))
        case .primaryCapsule:
            return AnyView(PrimaryCapsuleButton(color: color, configuration: configuration))
        case .secondaryLarge:
            return AnyView(SecondaryLargeButton(color: color, configuration: configuration))
        case .secondarySmall:
            return AnyView(SecondarySmallButton(color: color, configuration: configuration))
        case .secondaryCapsule:
            return AnyView(SecondaryCapsuleButton(color: color, configuration: configuration))
        }
    }
    
    struct PrimaryLargeButton: View {
        var color: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .font(.ewHeadline)
                .foregroundColor(.white)
                .padding(.vertical, .ewPaddingVerticalDefault)
                .frame(width:.infinity)
                .background(isEnabled ? color : Color.ewGray100)
                .cornerRadius(.ewCornerRadiusDefault)
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }
    
    
    struct SecondaryLargeButton: View {
        var color: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .font(.ewHeadline)
                .foregroundColor(isEnabled ? .ewBlack : .ewGray100)
                .padding(.vertical, .ewPaddingVerticalDefault)
                .frame(width:.infinity)
                .background(.white)
                .cornerRadius(.ewCornerRadiusDefault)
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }
    
    struct PrimarySmallButton: View {
        var color: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .font(.ewHeadline)
                .foregroundColor(.white)
                .padding(.vertical, .ewPaddingVerticalDefault)
                .padding(.horizontal, .ewPaddingHorizontalDefault)
                .background(isEnabled ? color : Color.ewGray100)
                .cornerRadius(.ewCornerRadiusDefault)
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }
    

    struct SecondarySmallButton: View {
        var color: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .font(.ewHeadline)
                .foregroundColor(isEnabled ? .ewBlack : .ewGray100)
                .padding(.vertical, .ewPaddingVerticalDefault)
                .padding(.horizontal, .ewPaddingHorizontalDefault)
                .background(.white)
                .cornerRadius(.ewCornerRadiusDefault)
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }
    
    
    
    struct PrimaryCapsuleButton: View {
        var color: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .font(.ewHeadline)
                .foregroundColor(.ewBlack)
                .padding(.vertical, .ewPaddingVerticalSmall)
                .padding(.horizontal, .ewPaddingHorizontalSmall)
                .background(isEnabled ? color : Color.ewGray100)
                .cornerRadius(.ewCornerRadiusRound)
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }
    
    struct SecondaryCapsuleButton: View {
        var color: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .font(.ewHeadline)
                .foregroundColor(.ewGray900)
                .padding(.vertical, .ewPaddingVerticalSmall)
                .padding(.horizontal, .ewPaddingHorizontalSmall)
                .background(isEnabled ? color : Color.ewGray100)
                .cornerRadius(.ewCornerRadiusRound)
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }

}

// MARK: - Usage

extension Button {
    /// Changes the appearance of the button
    func style(_ style: EWButton.Style, color: Color) -> some View {
        self.buttonStyle(EWButtonStyle(style: style, color: color))
    }
}

struct EWButton: View {
    
    enum Style {
        case primaryLarge, primarySmall, primaryCapsule, secondaryLarge, secondarySmall, secondaryCapsule
    }
    
    var text: String?
    var image: Image?
    var style: Style = .primaryLarge
    var color: Color = .ewPrimaryBase
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
                EWButton(text: "PrimaryLarge", style: .primaryLarge, action: { print("click") })
                EWButton(text: "SecondaryLarge", style: .secondaryLarge, action: { print("click") })
            }
            
            HStack(spacing: 5) {
                EWButton(text: "PrimarySmall", style: .primarySmall, action: { print("click") })
                EWButton(text: "SecondarySmall", style: .secondarySmall, action: { print("click") })
            }
            
            HStack(spacing: 5) {
                EWButton(text: "PrimaryCapusle", style: .primaryCapsule, action: { print("click") })
                EWButton(text: "SecondaryCapsule", style: .secondaryCapsule, action: { print("click") })
            }
            

            HStack(spacing: 5) {
                EWButton(text: "Text", action: { print("click") })
                EWButton(text: "Text", image:Image(systemName: "person.fill"), action: { print("click") })
                EWButton(image: Image(systemName: "person.fill"), action: { print("click") })
            }
            
            Button(action: { print("click") }, label: { Text("Custom") })
                .style(.primarySmall, color: .ewPrimaryBase)
        }
    .padding(10)
    }
}
