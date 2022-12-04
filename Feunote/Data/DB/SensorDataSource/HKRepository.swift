//
//  HKRepository.swift
//  HealthStatsApp
//
//  Created by DevTechie on 6/14/21.
//

import Foundation
import HealthKit

enum HealthDateRange {
    case hourly
    case daily
    case weekly
    case monthly
}

enum HealthStatQuantityType {
    case activeEnergyBurned
    case appleExerciseTime
    case appleStandTime
    case distanceWalkingRunning
    case stepCount
}

enum HealthStatCategoryType {
    case sleepAnalysis
}

final class HKRepository {
    var store: HKHealthStore?

    let allTypes = Set([
        HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!,
        HKQuantityType.quantityType(forIdentifier: .appleStandTime)!,
        HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKQuantityType.quantityType(forIdentifier: .stepCount)!,
        HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!
    ])

    var query: HKStatisticsCollectionQuery?

    init() {
        store = HKHealthStore()
    }

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard let store = store else {
            return completion(false)
        }

        store.requestAuthorization(toShare: [], read: allTypes) { success, _ in
            completion(success)
        }
    }

    func requestHealthQuantityData(by category: HealthStatQuantityType, by dateRange: HealthDateRange, completion: @escaping ([HealthQuantityData]) -> Void) {
        guard let store = store, let type = HKObjectType.quantityType(forIdentifier: healthQuantityIdentifier(category: category)) else {
            return
        }

        var startDate: Date?
        var endDate: Date?
        var anchorDate: Date?
        var dailyComponent: DateComponents?

        switch dateRange {
            case .hourly:
                endDate = Date()

                startDate = Calendar.current.startOfDay(for: endDate!)

                anchorDate = Calendar.current.startOfDay(for: endDate!)

                dailyComponent = DateComponents(hour: 1)
            case .daily:
                startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
                endDate = Date()
                anchorDate = Date.firstDayOfWeek()
                dailyComponent = DateComponents(day: 1)
            case .weekly:
                break
            case .monthly:
                break
        }

        var healthStats = [HealthQuantityData]()

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate!, intervalComponents: dailyComponent!)

        query?.initialResultsHandler = { _, statistics, _ in
            statistics?.enumerateStatistics(from: startDate!, to: endDate!, with: { stats, _ in
                let stat = HealthQuantityData(quantity: stats.sumQuantity(), date: stats.startDate)
                healthStats.append(stat)
            })
            completion(healthStats)
        }

        guard let query = query else {
            return
        }

        store.execute(query)
    }


/*
    func requestHealthCategoricalData(by category: HealthStatCategoryType, by dateRange: HealthDateRange, completion: @escaping (HealthCategoricalData) -> Void) {
        guard let store = store, let type = HKSampleType.categoryType(forIdentifier: healthCategoryIdentifier(category: category)) else {
            return
        }

        var startDate: Date?
        var endDate: Date?
        var anchorDate: Date?
        var dailyComponent: DateComponents?

        switch dateRange {
            case .hourly:
                endDate = Date()
                startDate = endDate!.addingTimeInterval(-1.0 * 60.0 * 60.0 * 24.0)
            case .daily:
                startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
                endDate = Date()
            case .weekly:
                break
            case .monthly:
                break
        }

        var healthStats = [HealthQuantityData]()
        let predicate = HKSampleQuery.predicateForSamples(withStart: startDate, end: endDate)

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

        query = HKSampleQuery(sampleType: type, predicate: predicate, limit: 0, sortDescriptors: [sortDescriptor]){ _, result, error in
            if error != nil {
                return
            }
            // Sum the sleep time
            var minutesSleepAggr = 0.0
            if let result = result {
                for item in result {
                    if let sample = item as? HKCategorySample {
                        if sample.value == HKCategoryValueSleepAnalysis.asleep.rawValue, sample.startDate >= startDate! {
                            let sleepTime = sample.endDate.timeIntervalSince(sample.startDate)
                            let minutesInAnHour = 60.0
                            let minutesBetweenDates = sleepTime / minutesInAnHour
                            minutesSleepAggr += minutesBetweenDates
                        }

                    }
                }
                let sleepHour = Double(String(format: "%.1f", minutesSleepAggr / 60))!
                print("HOURS: \(String(describing: sleepHour))")
                completion(HealthCategoricalData(start: startDate!, end: endDate!, quantity: sleepHour))
            }

//            if let result = result{
//
////                result.enumerateStatistics(from: startDate!, to: endDate!, with: { stats, _ in
////                    let stat = HealthQuantityData(quantity: stats.sumQuantity(), date: stats.startDate)
////                    healthStats.append(stat)
////                })
//                let data = result.map{HealthCategoricalData(start: $0.startDate, end: $0.endDate, quantity: $0.value)}
//                completion(data)
//            }
                
        }

        guard let query = query else {
            return
        }

        store.execute(query)
    }
*/
    
    private func healthQuantityIdentifier(category: HealthStatQuantityType) -> HKQuantityTypeIdentifier {
        switch category {
            case .activeEnergyBurned:
                return .activeEnergyBurned
            case .appleExerciseTime:
                return .appleExerciseTime
            case .appleStandTime:
                return .appleStandTime
            case .distanceWalkingRunning:
                return .distanceWalkingRunning
            case .stepCount:
                return .stepCount
        }
    }

    private func healthCategoryIdentifier(category: HealthStatCategoryType) -> HKCategoryTypeIdentifier {
        switch category {
            case .sleepAnalysis:
                return .sleepAnalysis
        }
    }

    let measurementFormatter = MeasurementFormatter()

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
