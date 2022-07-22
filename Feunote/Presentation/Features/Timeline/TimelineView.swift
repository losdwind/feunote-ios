//
//  TimelineView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import SwiftUI

enum TimelineTab {
    case MOMENTS
    case EVENTS
    case PERSONS
    case BRANCHES
}


class TimelineViewModel: ObservableObject {
        
    @Published var selectedMainTab:BottomTab = .timeline
    
    @Published var selectedTab:TimelineTab = .MOMENTS
//    @Published var selectedMenu:SearchType = .branch

    
}

struct TimelineView: View {
    
    @StateObject var timelinevm:TimelineViewModel = TimelineViewModel()
    @EnvironmentObject var commitvm:CommitViewModel
    @EnvironmentObject var branchvm:BranchViewModel
    @EnvironmentObject var profilevm:ProfileViewModel


    
    var body: some View {
        NavigationView {
            
            VStack{
                    
                    Picker("Filter", selection:$timelinevm.selectedTab){
                        // Todo: - check the TimelineManager Enum
                        Text("Moment").tag(TimelineTab.MOMENTS)
                            .foregroundColor(timelinevm.selectedTab == .MOMENTS ? .blue : .red)
                        
                        Text("Todo").tag(TimelineTab.EVENTS)
                            .foregroundColor(timelinevm.selectedTab == .EVENTS ? .blue : .red)
                        
                        
                        Text("Person")
                            .tag(TimelineTab.PERSONS)
                            .foregroundColor(timelinevm.selectedTab == .PERSONS ? .blue : .red)
                        Text("Branch")
                            .tag(TimelineTab.BRANCHES)
                            .foregroundColor(timelinevm.selectedTab == .BRANCHES ? .blue : .red)
                        
                        
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                
                
                
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
                                await branchvm.getAllBranchs(page:1)
                        }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                
            } //: VStack
            .padding()
            .frame(maxWidth:640)
            .navigationTitle(LocalizedStringKey("Timeline"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement:.navigationBarLeading){
                    
                    NavigationLink {
                        SearchView()
                    } label: {
                        Image(systemName: "magnifyingglass.circle")
                    }
                
                }
                
                ToolbarItem(placement:.navigationBarTrailing){
                    
                    NavigationLink {
                        InspireView()
                    } label: {
                        Image(systemName: "sparkles")
                    }
                }
                
            }
            .task {
                // MARK: - TODO Bug! page greater than 1 not work
                print("getting commits")
                    await commitvm.getAllCommits(page:1)
            }
        }
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
