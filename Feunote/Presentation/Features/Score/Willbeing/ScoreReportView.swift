//
//  ScoreReportView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/22.
//

import SwiftUI

struct ScoreReportView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
            Label {
                Text("Evaluation Report")
                    .font(.ewHeadline)

            } icon: {
                Image(systemName: "doc.text.image")
            }

            Text("We notice that your wellbeing index drops in the past week. One main reason is that your daily exercise didn't reach the average level of last month. Another main reason is one of your squad has been marked as not active during last month. It is very important for your personal wellbeing to maintain moderate exercise as well as social contact with your friends. ")
                // .lineLimit(5)
                .font(.ewFootnote)
                .lineSpacing(8)
        }
    }
}

struct WellbeingReportView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreReportView()
    }
}
