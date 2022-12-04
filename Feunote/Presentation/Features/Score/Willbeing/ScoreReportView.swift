//
//  ScoreReportView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/22.
//

import SwiftUI

struct ScoreReportView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
            Label {
                Text("Evaluation Report")
                    .font(.ewHeadline)

            } icon: {
                Image(systemName: "doc.text.image")
            }

            Text("We noticed that your wellbeing index decreased in the past week. One main reason was that your daily exercise didn't reach the average level of last month. Another main reason was one of your squad has been marked as  inactive during last month. We suggest you to do more exercise as well as improve social contact with your squad members. ")
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
