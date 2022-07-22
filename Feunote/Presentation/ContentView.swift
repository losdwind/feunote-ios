//
//  ContentView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import SwiftUI

enum BottomTab {
    case timeline
    case score
    case create
    case squad
    case community
}

struct ContentView: View {
    @State var selectedTab:BottomTab = BottomTab.create
    
    @StateObject var timelinevm:TimelineViewModel = TimelineViewModel()




    var body: some View {
        TabView(selection: $selectedTab) {
            TimelineView()
                .tabItem{
                    VStack{
                        Image(systemName: "text.redaction")
                        Text("Timeline")
                    }
                    
                }
                .tag(BottomTab.timeline)
            ScoreView()
                .tabItem {
                    VStack{
                        Image(systemName: "chart.bar.xaxis")
                        Text("Squad")
                    }
                }
                .tag(BottomTab.score)
            
            CreateView()
                .tabItem {
                    Image(systemName: "plus.square.fill")
                }
            
            SquadView()
                .badge(Text("15"))
                .tabItem{
                    VStack{
                        Image(systemName: "circles.hexagongrid")
                        Text("Squad")
                    }
                    
                }.tag(BottomTab.squad)
            
            CommunityView()
                .tabItem {
                    VStack{
                        Image(systemName: "building.2")
                        Text("Community")
                    }
                    
                }.tag(BottomTab.community)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
