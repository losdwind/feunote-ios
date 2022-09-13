//
//  PhysicalDailyWalkingStepsChartView.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/6.
//

import Foundation
import SwiftUI
struct PhysicalDailyWalkingStepsChartView: View {
    @EnvironmentObject var healthStoreManager: AppleHealthViewModel
//    @State var steps: [Step]
    @State var data: [CGFloat] = []

    var indicator: String {
        data.map { $0 * 5000 }.reduce(0, +).doubleToString(isPercentage: false)
    }

    var subTitle: String = "Walking Steps"

    @State var period = ChartPerid.Today
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
//            ScoreTitleView(title: "Steps", isShowingMenu: true, period: $period)
            VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
                Text("\(indicator) Steps")
                    .font(.ewTitle2)
                    .fontWeight(.bold)
                    .foregroundColor(.ewBlack)
                Text(subTitle)
                    .font(.ewHeadline)
                    .fontWeight(.bold)
                    .foregroundColor(.ewGray900)
            }
            VStack(alignment: .leading, spacing: .ewPaddingVerticalSmall) {
                Chart(data: data)
                    .chartStyle(
                        ColumnChartStyle(column: Capsule().foregroundColor(.green).frame(width: 4), spacing: 4)
                    )
                    .frame(height: 150)

                AxisLabels(.horizontal, data: 0 ... 4, id: \.self) {
                    if $0 == 0 {
                        Image(systemName: "sun.max")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    if $0 == 1 {
                        Text("6AM")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    if $0 == 2 {
                        Text("12PM")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    if $0 == 3 {
                        Text("6PM")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    if $0 == 4 {
                        Image(systemName: "moon")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .font(.footnote)
                .foregroundColor(.ewPrimaryBase)
                .frame(height: 20)
            }
        }
        .padding(.vertical, .ewPaddingVerticalDefault)
        .padding(.horizontal, .ewPaddingHorizontalDefault)
        .background(Color.ewGray50)
        .cornerRadius(.ewCornerRadiusDefault)
        .onAppear {
            if healthStoreManager.healthStore != nil {
                healthStoreManager.requestAuthorization { success in
                    if success {
                        healthStoreManager.calculateHourlyStepsInADay {
                            steps in
                            self.data = steps.map { step in
                                CGFloat(Double(steps.count)/20000.0)

                            }
                        }
                    }
                }
            }
        }
    }
}

struct PhysicalDailyWalkingStepsChartView_Previews: PreviewProvider {
    static var previews: some View {
        PhysicalDailyWalkingStepsChartView()
            .padding()
    }
}
