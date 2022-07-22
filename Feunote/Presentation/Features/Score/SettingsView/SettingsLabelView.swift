//
//  SettingsLabelView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/29.
//

import SwiftUI

import SwiftUI

struct SettingsLabelView: View {
    
    var labelText: String
    var labelImage: String
    
    var body: some View {
            HStack {
                
                Text(labelText)
                    .font(.ewHeadline)
                Spacer()
                Image(systemName: labelImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:14, height: 14)
                    
            }
            .foregroundColor(.ewBlack)
            .padding(.bottom, .ewPaddingVerticalDefault)
    }
}

struct SettingsLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLabelView(labelText: "Test Label", labelImage: "heart")
            .previewLayout(.sizeThatFits)
    }
}
