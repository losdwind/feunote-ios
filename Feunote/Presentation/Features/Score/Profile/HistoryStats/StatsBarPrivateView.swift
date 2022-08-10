//
//  PrivateStatsBarView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI

struct StatsBarPrivateView: View {
    
    @ObservedObject var profilevm:ProfileViewModel
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
        // MARK: POSTS
        HStack(alignment: .center) {
            
            // MARK: - No. Persons
            StatsBarEntryView(number: 14, text: "Branches")
            
            // MARK: - No.moments
            StatsBarEntryView(number: 131, text: "Moments")
            
            // MARK: - No. Completion/ Todos
            StatsBarEntryView(number: 15/20, text: "Todos")
            
            // MARK: - No. Persons
            StatsBarEntryView(number: 14, text: "Persons")
            
            
        }
    }
    }
}

struct PrivateStatsBarView_Previews: PreviewProvider {
    static var previews: some View {
        StatsBarPrivateView(profilevm: ProfileViewModel(saveProfileUserCase: SaveProfileUseCase(), getProfileByIDUserCase: GetProfileByIDUseCase(), getCurrentProfileUseCase: GetCurrentProfileUseCase(), deleteProfileUseCase: DeleteProfileUseCase()))

    }
}
