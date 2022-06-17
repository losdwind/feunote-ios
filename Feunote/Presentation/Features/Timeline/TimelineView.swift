//
//  TimelineView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import SwiftUI

struct TimelineView: View {
    var body: some View {
        NavigationView {
            
            VStack{
                HStack{
                    
                    Picker("Filter", selection:$timelineManager.selectedTab){
                        // Todo: - check the TimelineManager Enum
                        Text("Moment").tag(TimelineTab.MOMENTS)
                            .foregroundColor(timelineManager.selectedTab == .MOMENTS ? .blue : .red)
                        
                        Text("Event").tag(TimelineTab.EVENTS)
                            .foregroundColor(timelineManager.selectedTab == .EVENTS ? .blue : .red)
                        
                        
                        Text("Person")
                            .tag(TimelineTab.PERSONS)
                            .foregroundColor(timelineManager.selectedTab == .PERSONS ? .blue : .red)
                        Text("Branch")
                            .tag(TimelineTab.BRANCHES)
                            .foregroundColor(timelineManager.selectedTab == .BRANCHES ? .blue : .red)
                        
                        
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 50)
                }
                .padding(.horizontal,20)
                
                
                
                // TabView
                TabView(selection: $timelineManager.selectedTab) {
                    MomentListView(momentvm: momentvm, dataLinkedManager: dataLinkedManger, searchvm: searchvm, tagPanelvm: tagPanelvm).tag(TimelineTab.MOMENTS)
                    TodoListView(todovm: todovm, searchvm: searchvm, tagPanelvm: tagPanelvm, dataLinkedManager: dataLinkedManger).tag(TimelineTab.EVENTS)

                    PersonListView(personvm: personvm, dataLinkedManager: dataLinkedManger, searchvm: searchvm, tagPanelvm: tagPanelvm, timelineManager: timelineManager)
                        .tag(TimelineTab.PERSONS)
                    BranchCardListView(branchvm: branchvm, dataLinkedManager: dataLinkedManger, searchvm: searchvm, tagPanelvm: tagPanelvm)
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
                        isShowingSearchView.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass.circle")
                    }
                    
                    
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    <#code#>
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
