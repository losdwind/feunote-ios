//
//  SurveyView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/22.
//

import SwiftUI

struct SurveyCardsView: View {
    var body: some View {


            VStack(alignment: .center, spacing: .ewPaddingVerticalDefault) {
                NavigationLink {
                    SurveyCardDetailView(survey: SampleSurvey).preferredColorScheme(.light)
                } label: {
                    SurveyCardSingleView(title: "Big Five Personality", description: "The Big Five personality traits are extraversion (also often spelled extroversion), agreeableness, openness, conscientiousness, and neuroticism.", period: 15, numOfParticipants: 1233, backgroundColor: Color(hexString: "EDF7F9"))
                }

                NavigationLink {
                    SurveyCardDetailView(survey: SampleSurvey).preferredColorScheme(.light)
                } label: {
                    SurveyCardSingleView(title: "MBTI Test", description: "The test attempts to assign four categories: introversion or extraversion, sensing or intuition, thinking or feeling, judging or perceiving.", period: 10, numOfParticipants: 49423, backgroundColor: Color(hexString: "EDEBF8"))
                }
            }
        }
}

struct SurveyCardView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyCardsView()
            .padding()
    }
}
