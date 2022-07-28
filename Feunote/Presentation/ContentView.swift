//
//  ContentView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import PartialSheet
import SwiftUI
enum BottomTab {
    case timeline
    case score
    case create
    case squad
    case community
}

struct ContentView: View {
    @State var selectedTab: BottomTab = .timeline
    @EnvironmentObject var timelinevm: TimelineViewModel
    @EnvironmentObject var communityvm: CommunityViewModel
    @EnvironmentObject var squadvm:SquadViewModel
    var body: some View {
        NavigationView {
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
            .if(selectedTab == .timeline) { view in
                view
                    .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EWSelector(option: $timelinevm.selectedTab)
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            SearchView()
                        } label: {
                            Image("search")
                        }
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            InspireView()
                        } label: {
                            Image("analytics")
                        }
                    }
                }
            }
            .if(selectedTab == .score) { view in
                view
                    .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink {
                            ProfileView()
                        } label: {
                            HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
                                EWAvatarImage(image: UIImage(named: "demo-person-4")!, style: .small)
                            }
                        }
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image("settings")
                                .foregroundColor(.ewGray900)
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("Score")
                            .font(.ewHeadline)
                            .foregroundColor(.ewBlack)
                    }
                }
            }
            .if(selectedTab == .create) { view in
                view.toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Create").foregroundColor(.ewBlack)
                    }
                }
            }
            .if(selectedTab == .squad) { view in
                view
                    .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            SquadSearchView()
                        } label: {
                            Image("search")
                        }
                    }

                    ToolbarItem(placement: .principal) {
                        Text("Squad (12)")
                            .font(.ewHeadline)
                            .foregroundColor(.ewBlack)
                    }
                }
            }
            .if(selectedTab == .community) { view in
                view.toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EWSelector3(option: $communityvm.selectedCommunityTab, isPresentLocationPicker: $communityvm.isShowingLocationPickerView, location: $communityvm.selectedLocation)
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            NotificationView()
                        } label: {
                            Image("notification")
                        }
                    }
                }
            }

            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
