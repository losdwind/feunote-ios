//
//  HealthAbstractView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI

struct PhysicalAbstractView: View {
    @StateObject var healthStoreManager = AppleHealthViewModel()

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .center, spacing: .ewPaddingVerticalDefault) {
                // MARK: Number of Steps

                PhysicalDailyWalkingStepsChartView()

                PhysicalWeeklySleepHourChartView()

                PhysicalWeeklySentimentChartView()

                PhysicalWeeklyMeditationHourChartView()
            }
        }
        .environmentObject(healthStoreManager)
        .padding()
    }
}

struct PhysicalAbstractView_Previews: PreviewProvider {
    static var previews: some View {
        PhysicalAbstractView()
    }
}
