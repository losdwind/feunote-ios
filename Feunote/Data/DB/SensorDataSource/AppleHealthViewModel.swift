//
//  HealthViewModel.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/20.
//

import Amplify
import Foundation
import HealthKit

extension Date {
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

class AppleHealthViewModel: ObservableObject {
    var healthStore: HKHealthStore?

    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }

    func calculateDailyStepsInAWeek(completion: @escaping ([Step]) -> Void) {
        let query: HKStatisticsCollectionQuery?

        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        let endDate = Date()

        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: endDate)

        let anchorDate = Date.mondayAt12AM()

        let daily = DateComponents(day: 1)

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)

        query!.initialResultsHandler = { _, statisticsCollection, _ in
            guard let statisticsCollection = statisticsCollection, let startDate = startDate else { completion([])
                return}
            let steps = self.updateUIFromStatistics(statisticsCollection: statisticsCollection, startDate: startDate, endDate: endDate)
            completion(steps)
        }

        if let healthStore = healthStore {
            healthStore.execute(query!)
        }
    }

    func calculateHourlyStepsInADay(completion: @escaping ([Step]) -> Void) {
        let query: HKStatisticsCollectionQuery?

        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!

        let endDate = Date()

        let startDate = Calendar.current.startOfDay(for: endDate)

        let anchorDate = Calendar.current.startOfDay(for: endDate)

        let hourly = DateComponents(hour: 1)

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: hourly)

        query!.initialResultsHandler = { _, statisticsCollection, _ in
            guard let statisticsCollection = statisticsCollection else { completion([])
                return
            }
            let steps = self.updateUIFromStatistics(statisticsCollection: statisticsCollection, startDate: startDate, endDate: endDate)
            completion(steps)
        }

        if let healthStore = healthStore {
            healthStore.execute(query!)
        }
    }

    private func updateUIFromStatistics(statisticsCollection: HKStatisticsCollection, startDate: Date, endDate: Date) -> [Step] {
        var steps: [Step] = []


        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, _ in

            let count = statistics.sumQuantity()?.doubleValue(for: .count())

            let step = Step(count: Int(count ?? 0), localTimestamp: statistics.startDate)
            steps.append(step)
        }

        return steps
    }

    func requestAuthorization(completion: @escaping (_ success: Bool) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        let sleepType = HKCategoryType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
        let workoutType = HKWorkoutType.workoutType()
        let routeType = HKSeriesType.workoutRoute()

        guard let healthStore = healthStore else { return completion(false) }

        healthStore.requestAuthorization(toShare: [], read: [stepType, sleepType, workoutType, routeType]) { success, error in
            if success {
                completion(true)
            } else {
                print(error.debugDescription)
                completion(false)
            }
        }
    }
}
