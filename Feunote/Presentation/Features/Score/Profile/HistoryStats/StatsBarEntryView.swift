//
//  SingleEntryView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI

struct StatsBarEntryView: View {
    var number:Int
    var text:String
    var body: some View {
        VStack(alignment: .center, spacing: 5){
            Text(formatNumber(number))
                .font(.ewTitle2)
                .foregroundColor(.ewSecondaryBase)
                .padding(.bottom, .ewPaddingVerticalSmall)
            
            Capsule()
                .fill(Color.ewPrimaryBase)
                .frame(width: 20, height: 2, alignment: .center)
            
            Text(text)
                .foregroundColor(.ewPrimaryBase)
                .font(.footnote)
        }
        .padding(.ewPaddingHorizontalSmall)
        .padding(.ewPaddingVerticalSmall)
        .background(Color.ewPrimary100)
        .cornerRadius(.ewCornerRadiusDefault)
    }
}

struct SingleEntryView_Previews: PreviewProvider {
    static var previews: some View {
        StatsBarEntryView(number: 1111, text: "Apples")
    }
}
