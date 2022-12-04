//
//  Array+Extension.swift
//  Feunote
//
//  Created by Losd wind on 2022/11/30.
//

import Foundation
import UIKit
extension Array where Element == WordElement {
    static func generate(forSwiftUI: Bool = false) -> [WordElement] {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        var words = [WordElement]()
        for _ in 0...15 {
            words.append(
                WordElement(text: String((0...Int.random(in: 4...9)).map{ _ in letters.randomElement()! }),
                            color: UIColor(.purple),
                            fontName: "AvenirNext-Regular",
                            fontSize: forSwiftUI ? CGFloat.random(in:20...50) : CGFloat.random(in:50...150))
            )
        }
        return words
    }
}
