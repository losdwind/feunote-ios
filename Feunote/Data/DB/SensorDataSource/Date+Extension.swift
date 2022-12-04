//
//  Date+Extension.swift
//  HealthStatsApp
//
//  Created by DevTechie on 6/14/21.
//

import Foundation

extension Date {
    static func firstDayOfWeek() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) ?? Date()
    }
}
