//
//  ContentView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import SwiftUI
import PartialSheet
enum BottomTab {
    case timeline
    case score
    case create
    case squad
    case community
}

struct ContentView: View {
    @State var selectedTab: BottomTab = .timeline

    var body: some View {
        TabView(selection: $selectedTab) {
            TimelineView()
                .attachPartialSheetToRoot()
                .tabItem {
                    VStack {
                        Image("layout-ui-9")
                        Text("Timeline")
                    }
                }
                .tag(BottomTab.timeline)
            ScoreView()
                .tabItem {
                    VStack {
                        Image("chart-line")
                        Text("Score")
                    }
                }
                .tag(BottomTab.score)

            CreateView()
                .attachPartialSheetToRoot()
                .tabItem {
//
//                    Label("Add", image: "add")
//                        .foregroundColor(.ewWhite)
//                        .padding(4)
//                        .background(Color.ewPrimaryBase)
                    Image("tab-plus")

                }
                .tag(BottomTab.create)

            SquadView()
                .badge(Text("15"))
                .tabItem {
                    VStack {
                        Image("dashboard")
                        Text("Squad")
                    }

                }.tag(BottomTab.squad)

            CommunityView()
                .tabItem {
                    VStack {
                        Image("flame")
                        Text("Community")
                    }

                }.tag(BottomTab.community)
        }
        .accentColor(.ewSecondaryBase)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
