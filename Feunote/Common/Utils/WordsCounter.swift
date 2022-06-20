//
//  WordsCounter.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/17.
//

import Foundation

func wordCounter(content:String?) -> Int {
    if content {
        return content!.split{
            $0 == " " || $0.isNewline
        }.count
    } else {
        return 0
    }
    
}
