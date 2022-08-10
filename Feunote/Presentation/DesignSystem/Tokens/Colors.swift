//
//  Typography.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import SwiftUI

extension Color {
    // MARK: Primary Colors

    static let ewPrimaryBase = Color("feuPrimaryBase")
    static let ewPrimary100 = Color("feuPrimary100")
    static let ewPrimary300 = Color("feuPrimary300")
    static let ewPrimary500 = Color("feuPrimary500")
    static let ewPrimary700 = Color("feuPrimary700")

    // MARK: Secondary Colors

    static let ewSecondaryBase = Color("feuSecondaryBase")
    static let ewSecondary100 = Color("feuSecondary100")
    static let ewSecondary300 = Color("feuSecondary300")
    static let ewSecondary500 = Color("feuSecondary500")
    static let ewSecondary700 = Color("feuSecondary700")

    // MARK: Grayscale Colors

    /// background
    static let ewGray50 = Color("feuGray50")

    /// inactive
    static let ewGray100 = Color("feuGray100")

    /// inactive in dark mode
    static let ewGray900 = Color("feuGray900")

    /// background in dark mode
    static let ewGray950 = Color("feuGray950")

    /// font color
    static let ewBlack = Color("feuBlack")
    static let ewWhite = Color("feuWhite")

    // MARK: Alert Colors

    static let ewSuccess = Color("feuAlertSuccess")
    static let ewWarning = Color("feuAlertWarning")
    static let ewError = Color("feuAlertError")

    // MARK: - Decorative Color

    static let ewDecorative1 = Color("feuDecorative1")
    static let ewDecorative2 = Color("feuDecorative2")
    static let ewDecorative3 = Color("feuDecorative3")
    static let ewDecorative4 = Color("feuDecorative4")
    static let ewDecorative5 = Color("feuDecorative5")
}

struct Color_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack {
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(.ewPrimaryBase)
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(.ewSecondaryBase)
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(.ewGray50)
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(.ewGray100)
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(.ewWarning)
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(.ewError)
            }
            Text("Hello, World!")
                .foregroundColor(.ewPrimaryBase)
                .background(Color.ewSecondaryBase)
                .environment(\.colorScheme, .dark)
        }
        .padding()
    }
}
