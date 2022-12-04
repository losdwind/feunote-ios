//
//  PhysicalDailyWalkingStepsChartView.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/6.
//

import Foundation
import SwiftUI
struct PhysicalDailyMeditationHourChartView: View {
    @EnvironmentObject var healthStoreManager: AppleHealthViewModel

    var data: [CGFloat] = (0 ... 6).map { _ in CGFloat(arc4random_uniform(UInt32(10000))) / 10000 }
    var indicator: String {
        data.map { $0 * 1000 }.reduce(0, +).doubleToString(isPercentage: false)
    }

    var subTitle: String = "Average Meditation Minutes"

    @State var trim: CGFloat = 0

    @State var period = ChartPerid.Today
    let week = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
//            ScoreTitleView(title: "Sleep", isShowingMenu: true, period: $period)

            VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
//                Text("\(indicator) Mins")
                Text("23.6 Mins")
                    .font(.ewTitle2)
                    .fontWeight(.bold)
                    .foregroundColor(.ewBlack)
                Text(subTitle)
                    .font(.ewHeadline)
                    .fontWeight(.bold)
                    .foregroundColor(.ewGray900)
            }

            VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                Chart(data: data)
                    .chartStyle(
                        ColumnChartStyle(column: Capsule().foregroundColor(.ewSecondaryBase).frame(width: 4), spacing: 4)
                    )
                    .frame(height: 150)

                    .frame(height: 150)

                AxisLabels(.horizontal, data: 0 ... 6, id: \.self) {
                    Text(week[$0])
                        .font(.ewFootnote)
                }
                .font(.footnote)
                .foregroundColor(Color("Gradient3"))
                .frame(height: 20)
            }
        }
        .padding(.vertical, .ewPaddingVerticalDefault)
        .padding(.horizontal, .ewPaddingHorizontalDefault)
        .background(Color.ewGray50)
        .cornerRadius(.ewCornerRadiusDefault)
    }
}

struct PhysicalWeeklyMeditationHourChartView_Previews: PreviewProvider {
    static var previews: some View {
        PhysicalDailyMeditationHourChartView()
            .padding()
    }
}
