//
//  ScoreTitleView.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/3.
//

import SwiftUI

enum ChartPerid: String, CaseIterable {
    case Year
    case Month
    case Week
    case Today
    case Yesterday
}

struct ScoreTitleView: View {
    var title: String
    var isShowingMenu: Bool
    @Binding var period: ChartPerid
    var body: some View {
        HStack {
            Text(title)
                .font(.ewHeadline)

            Spacer()
            if isShowingMenu {
                Menu {
                    ForEach(ChartPerid.allCases, id: \.self) { period in
                        Button(period.rawValue) {
                            self.period = period
                        }
                    }

                } label: {
                    HStack(spacing: 4) {
                        Text("this week")

                        Image(systemName: "arrowtriangle.down.fill")
                            .scaleEffect(0.7)
                    }
                    .font(.ewSubheadline)
                    .foregroundColor(.ewGray900)
                    .padding(.horizontal, .ewPaddingHorizontalDefault)
                    .padding(.vertical, .ewPaddingVerticalSmall)
                    .background(Color.ewGray50)
                    .cornerRadius(.ewCornerRadiusRound)
                }
            }
        }
    }
}

struct ScoreTitleView_Previews: PreviewProvider {
    @State static var period = ChartPerid.Today
    static var previews: some View {
        ScoreTitleView(title: "Make me happy", isShowingMenu: true, period: $period)
    }
}
