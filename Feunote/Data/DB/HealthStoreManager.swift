//
//  HealthStoreManager.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/20.
//

import Foundation
import HealthKit
import Amplify

extension Date {
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

class HealthStoreManager:ObservableObject {
    
    var healthStore: HKHealthStore?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func calculateSteps(completion: @escaping (HKStatisticsCollection?) -> ()) {
        
        let query: HKStatisticsCollectionQuery?
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        
        let anchorDate = Date.mondayAt12AM()
        
        let daily = DateComponents(day: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        query!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore {
            healthStore.execute(query!)
        }
        
    }
    
    
    func updateUIFromStatistics(statisticsCollection: HKStatisticsCollection) -> [Step]{
        
        var steps:[Step] = []
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), localTimestamp: statistics.startDate)
            steps.append(step)
        }
        
        return steps
        
    }
    
    func requestAuthorization(completion: @escaping (_ success:Bool) -> ()) {
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        let sleepType = HKCategoryType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
        let workoutType = HKWorkoutType.workoutType()
        let routeType = HKSeriesType.workoutRoute()
        
        
        guard let healthStore = self.healthStore else { return completion(false) }
        
        healthStore.requestAuthorization(toShare: [], read: [stepType, sleepType, workoutType, routeType]) { (success, error) in
            if success {
                completion(true)
            } else {
                print(error.debugDescription)
                completion(false)
            }
        }
        
    }
    
}
