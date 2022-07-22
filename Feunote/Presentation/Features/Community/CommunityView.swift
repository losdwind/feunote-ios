//
//  CommunityView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/18.
//

import SwiftUI

struct CommunityView: View {
    @EnvironmentObject var communityvm:CommunityViewModel
    
    @State var isShowingLocationPickerView:Bool = false
    @State var isShowingNotificationView:Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .center, spacing: .ewPaddingHorizontalLarge) {
                    
                    CommunityTilesView()
                    
                    Picker("Filter", selection:$communityvm.selectedPopularity){
                        // Todo: - check the TimelineManager Enum
                        Text("Hot").tag(CategoryofPopularity.Popular)
                        
                        Text("Recent").tag(CategoryofPopularity.Recent)
                        
                        Text("Subscribed")
                            .tag(CategoryofPopularity.Subscribed)
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    
                    // TabView
                    TabView(selection: $communityvm.selectedPopularity) {
                        
                        CommunityBranchListView().tag(CategoryofPopularity.Popular)
                        CommunityBranchListView().tag(CategoryofPopularity.Recent)
                        CommunityBranchListView().tag(CategoryofPopularity.Subscribed)
                        
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                        isShowingLocationPickerView.toggle()
                    } label: {
                        Label("Beijing", image: "location-map")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingNotificationView.toggle()
                    } label: {
                        Image("notification")
                    }
                }
                
            }
            .foregroundColor(.ewBlack)
            .fullScreenCover(isPresented: $isShowingLocationPickerView, content: {
                LocationPickerView()
            })
            .fullScreenCover(isPresented: $isShowingNotificationView, content: {
                NotificationView()
            })
            .navigationTitle("Community")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
        
        
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
