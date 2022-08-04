//
//  OECDDataAPI.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/3.
//
import Foundation

class RemoteApiRepositoryImpl: RemoteApiRepositoryProtocol {
    func queryOECDInfo(location: String) async -> BetterLifeIndexData? {
        let url = "https://stats.oecd.org/SDMX-JSON/data/BLI/\(location).HO+HO_BASE+HO_HISH+HO_NUMR+IW+IW_HADI+IW_HNFW+JE+JE_LMIS+JE_EMPL+JE_LTUR+JE_PEARN+SC+SC_SNTWS+ES+ES_EDUA+ES_STCS+ES_EDUEX+EQ+EQ_AIRP+EQ_WATER+CG+CG_SENG+CG_VOTO+HS+HS_LEB+HS_SFRH+SW+SW_LIFS+PS+PS_FSAFEN+PS_REPH+WL+WL_EWLH+WL_TNOW.L.TOT+MN+WMN+HGH+LW/all?&dimensionAtObservation=allDimensions"
//    location: AUS+AUT+BEL+CAN+CHL+COL+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+SVN+ESP+SWE+CHE+TUR+GBR+USA+OECD+NMEC+BRA+RUS+ZAF
//    datasetIdentifier:String, filterExpression:String, agencyName:String, startPeriod:String, endPeriod:String
//        let url:String = "https://stats.oecd.org/SDMX-JSON/data/\(datasetIdentifier)/\(filterExpression)/\(agencyName)?startTime=\(startPeriod)&endTime=\(endPeriod)"

        return await withCheckedContinuation { continuation in
            let task = URLSession.shared.betterLifeIndexDataTask(with: URL(string: url)!) { betterLifeIndexData, _, _ in
                continuation.resume(returning: betterLifeIndexData)
            }
            task.resume()
        }
    }
}
