//
//  HealthStat.swift
//  HealthStatsApp
//
//  Created by DevTechie on 6/14/21.
//

import Foundation
import HealthKit

struct HealthQuantityData: Identifiable {
    let id = UUID()
    let quantity: HKQuantity?
    let date: Date
}

struct HealthCategoricalData: Identifiable {
    let id = UUID()
    let start : Date
    let end : Date
    let quantity: Double
}
