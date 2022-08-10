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

    private var getOwnedCommitsUseCase:GetCommitsUseCaseProtocol = GetOwnedCommitsUseCase()
    private var getOwnedBranchesUseCase:GetBranchesUseCaseProtocol = GetOwnedBranchesUseCase()

    @Published var selectedMainTab: BottomTab = .timeline
    @Published var selectedTab: TimelineTab = .All
    @Published var searchInput:String = ""

    @Published var fetchedOwnedCommits:[AmplifyCommit] = []
    @Published var fetchedOwnedBranches:[AmplifyBranch] = []


    @Published var hasError = false
    @Published var appError: AppError?

    func getAllCommits(page: Int) {
        Task {
            do {
                self.fetchedOwnedCommits = try await getOwnedCommitsUseCase.execute(page: page)
            } catch(let error){
                hasError = true
                appError = error as? AppError
            }
        }

    }

    func getAllBranchs(page: Int) {
        Task {
            do {
                self.fetchedOwnedBranches = try await getOwnedBranchesUseCase.execute(page: page)

            } catch {
                hasError = true
                appError = error as? AppError
            }
        }
    }


}

struct TimelineView: View {
    @EnvironmentObject var timelinevm: TimelineViewModel
    @EnvironmentObject var profilevm: ProfileViewModel

    var body: some View {
                // TabView
                TabView(selection: $timelinevm.selectedTab) {

                    CommitListView(fetchedCommits: timelinevm.fetchedOwnedCommits).tag(TimelineTab.All)

                    CommitListView(fetchedCommits: timelinevm.fetchedOwnedCommits.filter({ $0.commitType == .moment
                    })).tag(TimelineTab.MOMENTS)
                        .padding()
                    CommitListView(fetchedCommits: timelinevm.fetchedOwnedCommits.filter({ $0.commitType == .todo
                    })).tag(TimelineTab.EVENTS)
                        .padding()
                    CommitListView(fetchedCommits: timelinevm.fetchedOwnedCommits.filter({ $0.commitType == .person
                    }))
                        .tag(TimelineTab.PERSONS)
                        .padding()

                    BranchListView(branches: timelinevm.fetchedOwnedBranches)
                        .tag(TimelineTab.BRANCHES)
                        .padding()
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: 640)
            .toolbar {


                ToolbarItem(placement:.navigationBarLeading){
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
