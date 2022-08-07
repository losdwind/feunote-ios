//
//  SocialAbstract.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI
import Amplify

struct SocialAbstractView: View {
//    private var analytics:[Analytics] = analyticsData




    var body: some View {
        ScrollView(.vertical, showsIndicators: false){


        VStack(alignment:.leading){
            LazyVGrid(columns: [GridItem(),GridItem()]) {
                SocialStatCardView(statResult: 4, statResultIncremental: 1, isPercentage: false, title: "New Friends", description: "No. of new persons added")
                SocialStatCardView(statResult: 15, statResultIncremental: -3, isPercentage: false, title: "Mentioned", description: "No. of persons mentioned in your notes")
                SocialStatCardView(statResult: 0.15, statResultIncremental: 0.05, isPercentage: true, title: "Description Quality", description: "Data completeness of persons ")
                SocialStatCardView(statResult: 0.16, statResultIncremental: 0.4, isPercentage: true, title: "Cold Breaking", description: "No. of communication restarted by you")

                SocialStatCardView(statResult: 143, statResultIncremental: 23, isPercentage: false, title: "Talkative", description: "No. of messages send in Squad")
            }



        }

        }
        .padding()

    }
}

struct SocialAbstract_Previews: PreviewProvider {
    static var previews: some View {
        SocialAbstractView()
    }
}
