//
//  CareerAbstractView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI


struct Download: Identifiable{
    
    var id = UUID().uuidString
    var downloads: CGFloat
    var weekDay: String
}

struct CareerAbstractView: View {
    var downloads: [Download] = [

        Download(downloads: 500, weekDay: "Mon"),
        Download(downloads: 240, weekDay: "Tue"),
        Download(downloads: 350, weekDay: "Wed"),
        Download(downloads: 430, weekDay: "Thu"),
        Download(downloads: 690, weekDay: "Fri"),
        Download(downloads: 540, weekDay: "Sat"),
        Download(downloads: 920, weekDay: "Sun"),
    ]
    var body: some View {
            
            DoubleBarGraph(downloads:downloads )
            .padding()
    }
}

struct CareerAbstractView_Previews: PreviewProvider {
    static var previews: some View {
        CareerAbstractView()
    }
}
