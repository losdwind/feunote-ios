//
//  HealthAbstractView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI


struct PhysicalAbstractView: View {
    
    @StateObject var healthStoreManager = HealthViewModel()
    
    @State var steps:[Step] = []
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
                    // MARK: Number of Steps
                    BarChartView(data:
                                    ChartData(values: steps.map{($0.localTimestamp.description, $0.count)}
                                             ) ,
                                 title: "Steps",
                                 legend: "Weekly",
                                 valueSpecifier: "%.0f")

                    // MARK: Number of Acitivities
                    BarChartView(data: TestData.values ,
                                 title: "No. Activities",
                                 legend: "Weekly",
                                 style: Styles.barChartStyleNeonBlueLight,
                                 valueSpecifier: "%.0f")

                    
                    // MARK: Number of Non-identical Destinations
                    
                    BarChartView(data: TestData.values ,
                                 title: "No. Destinations",
                                 legend: "Weekly",
                                 style: Styles.barChartMidnightGreenLight,
                                 valueSpecifier: "%.0f")

                
                
            .onAppear {
                
                if healthStoreManager.healthStore != nil {
                    healthStoreManager.requestAuthorization { success in
                        if success {
                            healthStoreManager.calculateSteps { statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    // update the UI
                                    self.steps = healthStoreManager.updateUIFromStatistics(statisticsCollection: statisticsCollection)
                                }
                            }
                        }
                    }
                }
                
            }
        }
        .padding()
    }
}

struct PhysicalAbstractView_Previews: PreviewProvider {
    static var previews: some View {
        PhysicalAbstractView()
    }
}
