//
//  ProfileInfoPrivateView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/8.
//

import SwiftUI

struct StatsBarsView: View {
    @ObservedObject var profilevm:ProfileViewModel
    
    var body: some View {
        VStack{
            
                StatsBarPrivateView(profilevm: profilevm)
                
                StatsBarOpenView(profilevm: profilevm)
                

            
        }
        .padding()
    }
}

struct StatsBarsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsBarsView(profilevm: ProfileViewModel(saveProfileUserCase: SaveProfileUseCase(), getProfileByIDUserCase: GetProfileByIDUseCase(), getCurrentProfileUseCase: GetCurrentProfileUseCase(), deleteProfileUseCase: DeleteProfileUseCase(), viewDataMapper: ViewDataMapper()))
    }
}
