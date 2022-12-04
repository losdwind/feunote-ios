//
//  HealthAbstractView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI

struct PhysicalAbstractView: View {
    @StateObject var healthvm = HealthViewModel(repository: HKRepository())

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .center, spacing: .ewPaddingVerticalDefault) {
                // MARK: Number of Steps

                PhysicalHourlyWalkingStepsChartView()

                PhysicalDailySleepHourChartView()

                PhysicalDailySentimentChartView()

                PhysicalDailyMeditationHourChartView()
            }
        }
        .environmentObject(healthvm)
        .padding()
    }
}

struct PhysicalAbstractView_Previews: PreviewProvider {
    static var previews: some View {
        PhysicalAbstractView()
    }
}
