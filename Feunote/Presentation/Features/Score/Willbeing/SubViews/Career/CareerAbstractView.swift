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

        Download(downloads: 5, weekDay: "Mon"),
        Download(downloads: 2, weekDay: "Tue"),
        Download(downloads: 3, weekDay: "Wed"),
        Download(downloads: 4, weekDay: "Thu"),
        Download(downloads: 6, weekDay: "Fri"),
        Download(downloads: 5, weekDay: "Sat"),
        Download(downloads: 9, weekDay: "Sun"),
    ]
    var body: some View {
        ScrollView {
            LazyVStack {
                TodoCompletionGraphView(downloads:downloads )
            }

        }

            .padding()
    }
}

struct CareerAbstractView_Previews: PreviewProvider {
    static var previews: some View {
        CareerAbstractView()
    }
}
