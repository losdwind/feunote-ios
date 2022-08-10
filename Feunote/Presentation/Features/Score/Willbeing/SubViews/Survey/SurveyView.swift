//
//  SurveyView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/22.
//

import SwiftUI

struct SurveyView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
            Label {
                Text("Surveys")
                    .font(.ewHeadline)

            } icon: {
                Image(systemName: "doc.append")
            }

            VStack(alignment: .center, spacing: .ewPaddingVerticalDefault) {
                NavigationLink {} label: {
                    SurveyItemCard(title: "Big Five Personality", description: "The Big Five personality traits are extraversion (also often spelled extroversion), agreeableness, openness, conscientiousness, and neuroticism.", period: 15, numOfParticipants: 1233, backgroundColor: Color(hexString: "EDF7F9"))
                }

                NavigationLink {} label: {
                    SurveyItemCard(title: "MBTI Test", description: "The test attempts to assign four categories: introversion or extraversion, sensing or intuition, thinking or feeling, judging or perceiving.", period: 10, numOfParticipants: 49423, backgroundColor: Color(hexString: "EDEBF8"))
                }
            }
        }
    }
}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyView()
            .padding()
    }
}
