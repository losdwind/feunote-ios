//
//  CommunityView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/18.
//

import SwiftUI

struct CommunityView: View {
    @EnvironmentObject var communityvm: CommunityViewModel

    @State var isShowingLocationPickerView: Bool = false
    @State var isShowingNotificationView: Bool = false

    var body: some View {
        NavigationView {
                    // TabView
                    TabView(selection: $communityvm.selectedCommunityTab) {
                        CommunityBranchLocalView()
                            .tag(CommunityTab.Local)
                        CommunityBranchHotView()
                            .tag(CommunityTab.Hot)
                        CommunityBranchSubscribedView()
                            .tag(CommunityTab.Sub)

                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))



            .toolbar {

                ToolbarItem(placement:.navigationBarLeading){
                    EWSelector2(option: $communityvm.selectedCommunityTab, isPresentLocationPicker: $isShowingLocationPickerView, location: $communityvm.selectedLocation)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        NotificationView()
                    } label: {
                        Image("notification")
                    }

                }
            }
            .foregroundColor(.ewBlack)
            .fullScreenCover(isPresented: $isShowingLocationPickerView, content: {
                LocationPickerView()
            })
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
