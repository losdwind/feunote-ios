//
//  SettingsRowView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/29.
//

import SwiftUI


import SwiftUI

struct SettingsRowView: View {
    
    var leftIcon: String
    var text: String
    var color: Color
    
    var body: some View {
        HStack {
            
            Image(systemName: leftIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:14, height: 14)
                .foregroundColor(.ewWhite)
                .padding(.ewCornerRadiusDefault)
                .background(Color.ewPrimary300)
                .cornerRadius(.ewCornerRadiusDefault)
            
            Text(text)
                .font(.ewSubheadline)
                .foregroundColor(.ewBlack)
            
            Spacer()
            
            Image("arrow-right-1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 14, height: 14)
                .foregroundColor(.ewBlack)
            
        }
        .padding(.vertical, .ewPaddingVerticalSmall)
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(leftIcon: "heart.fill", text: "Row Title", color: .red)
            .previewLayout(.sizeThatFits)
    }
}

