//
//  SettingRowToggle.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/23.
//

import SwiftUI

struct SettingRowToggle: View {
    var leftIcon: String
    var text: String
    var color: Color
    @Binding var toggleState: Bool
    var body: some View {
        HStack {
            Image(systemName: leftIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 14, height: 14)
                .foregroundColor(.ewWhite)
                .padding(.ewCornerRadiusDefault)
                .background(Color.ewPrimary300)
                .cornerRadius(.ewCornerRadiusDefault)

            Text(text)
                .font(.ewSubheadline)
                .foregroundColor(.ewBlack)

            Spacer()

            EWToggle(toggleState: toggleState)
        }
        .padding(.vertical, .ewPaddingVerticalSmall)
    }
}

struct SettingRowToggle_Previews: PreviewProvider {
    @State static var toggleState: Bool = false
    static var previews: some View {
        SettingRowToggle(leftIcon: "heart.fill", text: "Row Title", color: .red, toggleState: $toggleState)
    }
}
