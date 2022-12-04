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
    @State var selectedTab: BottomTab = .timeline
    @EnvironmentObject var timelinevm: TimelineViewModel
    @EnvironmentObject var communityvm: CommunityViewModel
    @EnvironmentObject var squadvm: SquadViewModel
    @EnvironmentObject var profilevm: ProfileViewModel

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                TimelineView()
                    .tabItem {
                        VStack {
                            Image("layout-ui-9")
                            Text("Commits")
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
                    .tabItem {
                        Image("tab-plus")
                    }
                    .tag(BottomTab.create)

                SquadHomeView()
//                    .badge(Text("15"))
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
                                SearchView(input: $timelinevm.searchInput)
                            } label: {
                                Image("search").foregroundColor(Color.ewGray900)
                            }
                        }

                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink {
                                InspireView()
                            } label: {
                                Image("analytics").foregroundColor(Color.ewGray900)
                            }
                        }
                    }
            }
            .if(selectedTab == .score) { view in
                view
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink {
                                PrivateEditorView(user:profilevm.currentUser ?? AmplifyUser())
                            } label: {
                                HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
                                    PersonAvatarView(imageKey: profilevm.currentUser?.avatarKey, style: .small)
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
                                SearchView(input: $squadvm.searchInput)
                            } label: {
                                Image("search").foregroundColor(Color.ewGray900)
                            }
                        }

                        ToolbarItem(placement: .principal) {
                            Text("Squad")
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
                            Image("notification").foregroundColor(Color.ewGray900)
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
