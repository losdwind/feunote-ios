//
//  CommunityView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/18.
//

import SwiftUI

struct CommunityView: View {
    @EnvironmentObject var communityvm: CommunityViewModel


    var body: some View {
                    // TabView
                    TabView(selection: $communityvm.selectedCommunityTab) {
                        CommunityBranchHotView()
                            .padding()
                            .tag(CommunityTab.Hot)

                        CommunityBranchSubscribedView()
                            .padding()
                            .tag(CommunityTab.Sub)
                        CommunityBranchLocalView()
                            .padding()
                            .tag(CommunityTab.Local)

                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))



            .toolbar {

                ToolbarItem(placement:.navigationBarLeading){
                    EWSelector3(option: $communityvm.selectedCommunityTab, isPresentLocationPicker: $communityvm.isShowingLocationPickerView, location: $communityvm.selectedLocation)
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
            .fullScreenCover(isPresented: $communityvm.isShowingLocationPickerView, content: {
                LocationPickerView(selectedLocation: $communityvm.selectedLocation)
            })
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
