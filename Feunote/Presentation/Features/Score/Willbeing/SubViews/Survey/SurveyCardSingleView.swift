//
//  SurveyItemCard.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/2.
//

import SwiftUI

struct SurveyCardSingleView: View {
    var title: String
    var description: String
    var period: Int
    var numOfParticipants: Int
    var backgroundColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalSmall) {
            Text(title)
                .font(.ewHeadline)
                .foregroundColor(.ewBlack)
            Text(description)
                .font(.ewFootnote)
                .foregroundColor(.ewGray900)
                .multilineTextAlignment(.leading)
            HStack {
                HStack {
                    Image("time")
                        .foregroundColor(.ewGray900)
                    Text("\(period) min")
                        .font(.ewFootnote)
                        .foregroundColor(.ewBlack)
                }
                Spacer()
                HStack {
                    Image("user")
                        .foregroundColor(.ewGray900)

                    Text("\(numOfParticipants)")
                        .font(.ewFootnote)
                        .foregroundColor(.ewBlack)
                }
            }
        }
        .padding(.vertical, .ewCornerRadiusDefault)
        .padding(.horizontal, .ewPaddingHorizontalDefault)
        .background(backgroundColor)
        .cornerRadius(.ewCornerRadiusDefault)
    }
}

struct SurveyItemCard_Previews: PreviewProvider {
    static var previews: some View {
        SurveyCardSingleView(title: "Big Five Personality", description: "The Big Five personality traits are extraversion (also often spelled extroversion), agreeableness, openness, conscientiousness, and neuroticism.", period: 15, numOfParticipants: 1233, backgroundColor: Color(hexString: "EDF7F9"))
            .padding()
        SurveyCardSingleView(title: "MBTI Test", description: "The test attempts to assign four categories: introversion or extraversion, sensing or intuition, thinking or feeling, judging or perceiving.", period: 10, numOfParticipants: 49423, backgroundColor: Color(hexString: "EDEBF8"))
            .padding()
    }
}
