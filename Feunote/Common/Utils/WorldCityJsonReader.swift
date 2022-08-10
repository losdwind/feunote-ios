//
//  WorldCityJsonReader.swift
//  Beliski
//
//  Created by Losd wind on 2021/12/5.
//

import Foundation

class WorldCityJsonReader: ObservableObject {
    static let shared: WorldCityJsonReader = .init()

    lazy var worldCity: WorldCity = readFile(name: "worldcitylist")!

    func readFile(name: String) -> WorldCity? {
        guard let data = readLocalJSONFile(forName: name) else { return nil }

        let decoder = JSONDecoder()
        let worldCity = try? decoder.decode(WorldCity.self, from: data)
        return worldCity
    }

    // MARK: - WordCity

    struct WorldCity: Codable {
        let cityList: [CityList]
        let classifyList: [String]

        enum CodingKeys: String, CodingKey {
            case cityList = "city_list"
            case classifyList = "classify_list"
        }
    }

    // MARK: - CityList

    struct CityList: Codable, Identifiable {
        let k: String
        let n: [N]
        let id: UUID = .init()

        enum CodingKeys: String, CodingKey {
            case k
            case n
        }
    }

    // MARK: - N

    struct N: Codable, Identifiable, Hashable {
        let c: String
        let cityCode: Int
        let m: String
        let n: String
        let x: String
        let y: String
        let ycode: Int
        let p: String?
        let id: UUID = .init()

        enum CodingKeys: String, CodingKey {
            case c
            case cityCode
            case m
            case n
            case x
            case y
            case ycode
            case p
        }
    }
}
