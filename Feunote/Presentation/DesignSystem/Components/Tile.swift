//
//  EWTile.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import SwiftUI

struct EWTile: View {
    var title:String
    var description:String
    var backgroundColor:Color = Color.ewGray50
    
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
            Text(title)
                .font(.ewHeadline)
                .foregroundColor(.ewBlack)
            Text(description)
                .font(.ewFootnote)
                .foregroundColor(.ewGray900)
        }
        .padding(.vertical, .ewPaddingVerticalDefault)
        .padding(.horizontal, .ewPaddingVerticalLarge)
        .frame(width: 164,height: 67)
        .background(backgroundColor)
        .cornerRadius(.ewCornerRadiusDefault)

    }
    }

struct EWTile_Previews: PreviewProvider {
    static var previews: some View {
        EWTile(title: "Challenge", description: "Savoring, Gratitude")
    }
}
