//
//  ButtonGroupContainer.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import Foundation
import SwiftUI


/// Struct to create a row of formatted buttons
struct EWButtonGroup: View {
    
    var icon : Image?
    var buttonItems : Int
    var text: String = ""
    var colorStyle : ColorStyle
    var size : Size
    
    enum Size {
        case giant, large, medium, small, tiny
        
        var style: ButtonGroupStyle.SizeStyle {
            switch self {
            case .giant: return ButtonGroupStyle.SizeStyle.giant
            case .large: return ButtonGroupStyle.SizeStyle.large
            case .medium: return  ButtonGroupStyle.SizeStyle.medium
            case .small: return  ButtonGroupStyle.SizeStyle.small
            case .tiny: return ButtonGroupStyle.SizeStyle.tiny
            }
        }
        
    }
    
    typealias ColorStyle = ButtonGroupStyle.Style
    
    
    var body : some View {
        VStack {
            HStack(spacing: 1) {
                ForEach(0..<buttonItems) { i in
                    Button(action: {}, label: {
                        Group {
                            if self.icon != nil {
                                self.icon!.ewSquare(width: self.size.style.iconScale)
                            } else {
                                Text(self.text)
                            }
                        }
                    }
                    ).buttonStyle(ButtonGroupStyle(sizesStyle: self.size.style, colorStyle: self.colorStyle))
                }
                
            }.cornerRadius(self.size.style.frameWidth / 10)
                .overlay(RoundedRectangle(cornerRadius: ((colorStyle == ColorStyle.outline)) ? (self.size.style.frameWidth / 10) : 0).stroke(Color.ewActiveBasic, lineWidth:(colorStyle == ColorStyle.outline) ? 1 : 0))
        }
    }
}


struct ButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        VStack {

            EWButtonGroup(icon: Image(systemName: "star"), buttonItems: 5, text: "won't read me", colorStyle: .primary, size: .giant)

            EWButtonGroup(icon: nil, buttonItems: 5, text: "L", colorStyle: .basic, size: .large)
            
            EWButtonGroup(icon: Image(systemName: "person"), buttonItems: 5, text: "hi", colorStyle: .outline, size: .medium)

            EWButtonGroup(icon: nil, buttonItems: 5, text: "S", colorStyle: .primary, size: .small)

            EWButtonGroup(icon: Image(systemName: "umbrella.fill"), buttonItems: 5, text: "T", colorStyle: .basic, size: .tiny)
        }
    }
}
