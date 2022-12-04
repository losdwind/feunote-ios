//
//  DetailViewModel.swift
//  HealthStatsApp
//
//  Created by DevTechie on 6/14/21.
//

import Foundation
import HealthKit

final class HealthViewModel: ObservableObject {
    var repository: HKRepository
    
    
    let measurementFormatter = MeasurementFormatter()

    init(repository: HKRepository) {
        self.repository = repository
    }
    
    func value(from stat: HKQuantity?) -> (value: Int, desc: String) {
        guard let stat = stat else { return (0, "") }
        
        measurementFormatter.unitStyle = .long
        
        if stat.is(compatibleWith: .kilocalorie()) {
            let value = stat.doubleValue(for: .kilocalorie())
            return (Int(value), stat.description)
        } else if stat.is(compatibleWith: .meter()) {
            let value = stat.doubleValue(for: .mile())
            let unit = Measurement(value: value, unit: UnitLength.miles)
            return (Int(value), measurementFormatter.string(from: unit))
        } else if stat.is(compatibleWith: .count()) {
            let value = stat.doubleValue(for: .count())
            return (Int(value), stat.description)
        } else if stat.is(compatibleWith: .minute()) {
            let value = stat.doubleValue(for: .minute())
            return (Int(value), stat.description)
        }
        
        return (0, "")
    }
}
