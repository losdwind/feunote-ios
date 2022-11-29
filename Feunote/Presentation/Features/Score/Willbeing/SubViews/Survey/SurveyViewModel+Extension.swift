//
//  SurveyManager.swift
//  SwiftSurvey
//
//  Created by jclaan on 8/4/21.
//

import Foundation

extension SurveyViewModel {
    
    static func LoadFromFile(url: URL) throws -> SurveyViewModel {
        
        let jsonData = try Data(contentsOf: url)
        let survey = try JSONDecoder().decode(SurveyViewModel.self, from: jsonData)
        return survey
        
    }
    
    static func SaveToFile(survey: SurveyViewModel, url: URL) throws {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let jsonData = try encoder.encode(survey)
        try jsonData.write(to: url, options: [.atomic])
        
    }

    static func saveSurveySource(survey:SurveyViewModel) async {

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(survey)
            let key = try await SaveDataUseCase().execute(data: jsonData, key: "Survey/\(UUID())")
            try await SaveSourceUseCase().execute(sourceType: .survey, sourceData:  "{\"S3Key\": \"\(key)\"}")
        } catch(let error) {
            print("failed to save survey, error :\(error)")
        }
    }

}


func TitleToTag( _ tag : String ) -> String {
    
    let invalidCharacters = CharacterSet(charactersIn: "\\/:*?\"<>|")
        .union(.newlines)
        .union(.illegalCharacters)
        .union(.controlCharacters)
    
    return tag
        .components(separatedBy: invalidCharacters)
        .joined(separator: "")
    
    .components(separatedBy: .whitespacesAndNewlines)
        .filter { !$0.isEmpty }
        .joined(separator: "-")
    
}

extension Bundle {
    var releaseVersionNumber: String {
        return (infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    }
    var buildVersionNumber: String {
        return (infoDictionary?["CFBundleVersion"] as? String) ?? ""
    }
}
