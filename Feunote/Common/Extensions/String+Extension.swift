//
//  String+Extension.swift
//  Feunote
//
//  Created by Losd wind on 2022/11/30.
//

import Foundation
import NaturalLanguage
extension String {
    func lemmatized() -> String {
        let tagger = NLTagger(tagSchemes: [.lemma])
        tagger.string = self

        var result = [String]()

        tagger.enumerateTags(in: self.startIndex..<self.endIndex, unit: .word, scheme: .lemma) { tag, tokenRange in
            let stemForm = tag?.rawValue ?? String(self[tokenRange])
            result.append(stemForm)
            return true
        }

        return result.joined()
    }
}


extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
