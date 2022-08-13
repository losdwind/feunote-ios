//
//  TimelineView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import SwiftUI

enum TimelineTab: String, CaseIterable {
    case All
    case MOMENTS
    case EVENTS
    case PERSONS
    case BRANCHES
}

class TimelineViewModel: ObservableObject {
    private var getOwnedCommitsUseCase: GetCommitsUseCaseProtocol = GetOwnedCommitsUseCase()
    private var getOwnedBranchesUseCase: GetBranchesUseCaseProtocol = GetOwnedBranchesUseCase()

    @Published var selectedMainTab: BottomTab = .timeline
    @Published var selectedTab: TimelineTab = .All
    @Published var searchInput: String = ""

    @Published var fetchedOwnedCommits: [AmplifyCommit] = []
    @Published var fetchedOwnedBranches: [AmplifyBranch] = []

    @Published var hasError = false
    @Published var appError: Error?

    @MainActor func getAllCommits(page: Int) {
        Task {
            do {
                self.fetchedOwnedCommits = try await getOwnedCommitsUseCase.execute(page: page)
                print("fetched commits: \(fetchedOwnedCommits.count)")
            } catch {
                hasError = true
                appError = error as? Error
            }
        }
    }

    @MainActor func getAllBranchs(page: Int) {
        Task {
            do {
                self.fetchedOwnedBranches = try await getOwnedBranchesUseCase.execute(page: page)
                print("fetched branches: \(fetchedOwnedBranches.count)")

            } catch {
                hasError = true
                appError = error as? Error
            }
        }
    }
}

struct TimelineView: View {
    @EnvironmentObject var timelinevm: TimelineViewModel

    var body: some View {
        // TabView
        TabView(selection: $timelinevm.selectedTab) {

            CommitListView(fetchedCommits: timelinevm.fetchedOwnedCommits).tag(TimelineTab.All)
                .onAppear{
                    timelinevm.getAllCommits(page: 1)
                }
            CommitListView(fetchedCommits: timelinevm.fetchedOwnedCommits.filter { $0.commitType == .moment
            }).tag(TimelineTab.MOMENTS)
            CommitListView(fetchedCommits: timelinevm.fetchedOwnedCommits.filter { $0.commitType == .todo
            }).tag(TimelineTab.EVENTS)
            CommitListView(fetchedCommits: timelinevm.fetchedOwnedCommits.filter { $0.commitType == .person
            })
            .tag(TimelineTab.PERSONS)

            BranchListView(branches: timelinevm.fetchedOwnedBranches)
                .tag(TimelineTab.BRANCHES)
                .onAppear{
                    timelinevm.getAllBranchs(page: 1)
                }
        }

        .padding()
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxWidth: 640)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EWSelector(option: $timelinevm.selectedTab)
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SearchView(input: $timelinevm.searchInput)
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
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
