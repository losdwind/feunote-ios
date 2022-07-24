//
//  TimelineView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import SwiftUI

enum TimelineTab: String, CaseIterable {
    case MOMENTS
    case EVENTS
    case PERSONS
    case BRANCHES
}

class TimelineViewModel: ObservableObject {
    @Published var selectedMainTab: BottomTab = .timeline

    @Published var selectedTab: TimelineTab = .MOMENTS
//    @Published var selectedMenu:SearchType = .branch
}

struct TimelineView: View {
    @StateObject var timelinevm: TimelineViewModel = .init()
    @EnvironmentObject var commitvm: CommitViewModel
    @EnvironmentObject var branchvm: BranchViewModel
    @EnvironmentObject var profilevm: ProfileViewModel

    var body: some View {
        NavigationView {
            VStack {

                // TabView
                TabView(selection: $timelinevm.selectedTab) {
                    MomentListView().tag(TimelineTab.MOMENTS)
                    TodoListView().tag(TimelineTab.EVENTS)
                    PersonListView()
                        .tag(TimelineTab.PERSONS)
                    BranchCardListView()
                        .tag(TimelineTab.BRANCHES)
                        .task {
                            print("getting branches")
                            await branchvm.getAllBranchs(page: 1)
                        }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            } //: VStack
            .padding()
            .frame(maxWidth: 640)
            .toolbar {


                ToolbarItem(placement:.navigationBarLeading){
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
            .task {
                // MARK: - TODO Bug! page greater than 1 not work

                print("getting commits")
                await commitvm.getAllCommits(page: 1)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
