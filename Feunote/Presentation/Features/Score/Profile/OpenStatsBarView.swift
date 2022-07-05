//
//  StatsBarView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/29.
//

import SwiftUI


struct OpenStatsBarView: View {
    @ObservedObject var profilevm:ProfileViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
        HStack(alignment: .center){
            
            // MARK: POSTS
        
            SingleEntryView(number: 13, text: "Posts")
            
            // MARK: LIKES
        
            SingleEntryView(number: 213, text: "Likes")
            
            // MARK: Subs

            SingleEntryView(number: 7, text: "Subs")
            
            
            // MARK: Messages
            SingleEntryView(number: 1293, text: "Msgs.")
            
        }
            
        }

    }
}

struct StatsBarView_Previews: PreviewProvider {
    static var previews: some View {
        OpenStatsBarView(profilevm: ProfileViewModel(saveProfileUserCase: SaveProfileUseCase(), getProfileByIDUserCase: GetProfileByIDUseCase(), getCurrentProfileUseCase: GetCurrentProfileUseCase(), deleteProfileUseCase: DeleteProfileUseCase(), viewDataMapper: ViewDataMapper()))
    }
}


