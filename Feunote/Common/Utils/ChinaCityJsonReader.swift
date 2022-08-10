//
//  LocationJsonParser.swift
//  Beliski
//
//  Created by Losd wind on 2021/12/5.
//

import Foundation

func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}

class ChinaCityJsonReader {
    static let shared: ChinaCityJsonReader = .init()

    lazy var chinaCity: ChinaCity = readFile(name: "chinacitylist")!

    func readFile(name: String) -> ChinaCity? {
        guard let data = readLocalJSONFile(forName: name) else { return nil }

        let decoder = JSONDecoder()
        let chinaCity = try? decoder.decode(ChinaCity.self, from: data)
        return chinaCity
    }

    // MARK: - ChinaCity

    struct ChinaCity: Codable {
        let cityList: [CityList]
        let classifyList: [String]

        enum CodingKeys: String, CodingKey {
            case cityList = "city_list"
            case classifyList = "classify_list"
        }
    }

    // MARK: - CityList

    struct CityList: Codable {
        let k: String
        let n: [N]

        enum CodingKeys: String, CodingKey {
            case k
            case n
        }
    }

    // MARK: - N

    struct N: Codable {
        let c: String
        let cityCode: Int
        let n: String
        let p: String

        enum CodingKeys: String, CodingKey {
            case c
            case cityCode
            case n
            case p
        }
    }
}
