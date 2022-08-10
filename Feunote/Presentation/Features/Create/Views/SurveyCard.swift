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
            EWTile(title: "Survey", description: "MBTI, Big Five, Perma")
            EWTile(title: "Challenge", description: "Savoring, Gratitude")
        }
    }
}

struct SurveyCard_Previews: PreviewProvider {
    static var previews: some View {
        SurveyCard()
    }
}
