//
//  ScoreOverViewChart.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/22.
//

import SwiftUI

struct ScoreOverallView: View {
    var wbScore: WBScore

    var body: some View {
        // Score
        VStack(alignment: .center, spacing: .ewPaddingVerticalDefault) {
            Text("\(Int(wbScore.career + wbScore.social + wbScore.physical + wbScore.financial + wbScore.community) * wbScore.fullScoreForEachComponent)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.ewPrimaryBase)

            Text("Wellbeing Index")
                .font(.ewHeadline)
                .foregroundColor(.ewPrimaryBase)
        }

        // Chart
        Image("demo-chart-main")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 150)
    }
}

struct ScoreOverallView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreOverallView(wbScore: WBScore(dateCreated: Date(), career: 145 / 200, social: 133 / 200, physical: 178 / 200, financial: 108 / 200, community: 89 / 200))
    }
}
