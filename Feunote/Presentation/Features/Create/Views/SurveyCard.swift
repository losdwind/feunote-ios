//
//  SurveyCard.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import SwiftUI

struct SurveyCard: View {
    var body: some View {
        HStack(alignment: .top, spacing: .ewPaddingHorizontalDefault) {
            VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                Text("Survey")
                    .font(.ewHeadline)
                    .foregroundColor(.black)
                Text("MBTI, Big Five, Perma")
                    .font(.ewFootnote)
                    .foregroundColor(.ewGray900)
            }
            .padding(.vertical, .ewPaddingVerticalDefault)
            .padding(.horizontal, .ewPaddingVerticalLarge)
            .frame(width: 164,height: 67)
            .background(Color.ewGray50)
            .cornerRadius(.ewCornerRadiusDefault)

            VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                Text("Challenge")
                    .font(.ewHeadline)
                    .foregroundColor(.black)
                Text("Savoring, Gratitude")
                    .font(.ewFootnote)
                    .foregroundColor(.ewGray900)
            }
            .padding(.vertical, .ewPaddingVerticalDefault)
            .padding(.horizontal, .ewPaddingVerticalLarge)
            .frame(width: 164,height: 67)
            .background(Color.ewGray50)
            .cornerRadius(.ewCornerRadiusDefault)

        }

    }
}

struct SurveyCard_Previews: PreviewProvider {
    static var previews: some View {
        SurveyCard()
    }
}
