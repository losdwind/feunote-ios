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

    
    @Published var showFilterView: Bool = false
    
    @Published var showSearchView: Bool = false
//    @Published var theme:Theme = .full
    
    @Published var isShowingSearchView:Bool = false
    
}

struct TimelineView: View {
    
    @StateObject var timelinevm:TimelineViewModel = TimelineViewModel()
    @EnvironmentObject var momentvm:MomentViewModel
    @EnvironmentObject var todovm:TodoViewModel
    @EnvironmentObject var personvm:PersonViewModel
    @EnvironmentObject var branchvm:BranchViewModel
    @EnvironmentObject var profilevm:ProfileViewModel


    
    var body: some View {
        NavigationView {
            
            VStack{
                HStack{
                    
                    
                    
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
                    .padding(.horizontal, 50)
                }
                .padding(.horizontal,20)
                
                
                
                // TabView
                TabView(selection: $timelinevm.selectedTab) {
                    MomentListView(momentvm: momentvm).tag(TimelineTab.MOMENTS)
                    TodoListView(todovm: todovm).tag(TimelineTab.EVENTS)
                    PersonListView(personvm: personvm)
                        .tag(TimelineTab.PERSONS)
                    BranchCardListView(branchvm: branchvm)
                        .tag(TimelineTab.BRANCHES)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                
            } //: VStack
            .frame(maxWidth:640)
            .navigationTitle(LocalizedStringKey("Timeline"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement:.navigationBarLeading){
                    
                    Button {
                        timelinevm.isShowingSearchView.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass.circle")
                    }
                    
                    
                }
                
               
                
                
                
                ToolbarItem(placement:.navigationBarTrailing){
                    
                    NavigationLink {
                        InspireView(profilevm: profilevm)
                    } label: {
                        Image(systemName: "sparkles")
                    }
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
