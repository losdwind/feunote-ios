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
    @StateObject var momentvm:MomentViewModel = MomentViewModel(saveMomentUseCase: SaveMomentUseCase(), deleteMomentUseCase: DeleteMomentUseCase(), getAllMomentsUseCase: GetAllMomentsUseCase())
    @StateObject var todovm:TodoViewModel = TodoViewModel(saveTodoUseCase: SaveTodoUseCase(), deleteTodoUseCase: DeleteTodoUseCase(), getAllTodosUseCase: GetAllTodosUseCase())
    @StateObject var personvm:PersonViewModel = PersonViewModel(savePersonUserCase: SavePersonUseCase(), getAllPersons: GetAllPersonsUseCase(), deletePersonUseCase: DeletePersonUseCase())
    @StateObject var branchvm:BranchViewModel = BranchViewModel(saveBranchUserCase: SaveBranchUseCase(), getAllBranchesUseCase: GetAllBranchesUseCase(), deleteBranchUseCase: DeleteBranchUseCase())
    @StateObject var profilevm:ProfileViewModel = ProfileViewModel()



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
                .environmentObject(momentvm)
            PanelView(profilevm: profilevm)
                .tabItem {
                    VStack{
                        Image(systemName: "circles.hexagongrid")
                        Text("Squad")
                    }
                }
                .tag(BottomTab.score)
            
            CreateView(momentvm: momentvm, todovm: todovm, personvm: personvm, branchvm: branchvm)
                .tabItem {
                    Image(systemName: "plus.square.fill")
                }
            
            EmptyView()
//            SquadView()
                .badge(Text("15"))
                .tabItem{
                    VStack{
                        Image(systemName: "circles.hexagongrid")
                        Text("Squad")
                    }
                    
                }.tag(BottomTab.squad)
            
            EmptyView()
//            CommunityView()
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
