//
//  Toggles.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import SwiftUI


public struct EWToggle: View {
    

    @State var toggleState: Bool = true
    
    struct ColoredToggleStyle: ToggleStyle {
        var onColor = Color.ewSecondaryBase
        var offColor = Color.ewGray100
        var thumbColor = Color.white
        
        func makeBody(configuration: Self.Configuration) -> some View {
            withAnimation(.easeInOut(duration: 0.1)){
            Button(action: { configuration.isOn.toggle() } ) {
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
                            Image(systemName: configuration.isOn ? "checkmark" : "")
                                .font(.system(size: 12, weight: .black))
                                .foregroundColor(onColor)
                                .offset(x: configuration.isOn ? 10 : -10)
                            
                        }
                    )
            }
            .font(.title)
            .padding(.horizontal)
        }
        }
    }
    
    
    public var body: some View {
        primary()
    }
    
    
    fileprivate func primary() -> some View {
        Toggle("", isOn: $toggleState)
            .toggleStyle(
                ColoredToggleStyle(
                    onColor: .ewSecondaryBase,
                    offColor: .ewGray100,
                    thumbColor: .white))
    }

    
}

struct Toggles_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            EWToggle(toggleState: true)
            EWToggle(toggleState: false)

        }
    }
}
