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
                Text("Private")
                    .font(.title3.bold())
                    .foregroundColor(Color.pink)
                    .frame(minWidth:80)
                
                StatsBarPrivateView(profilevm: profilevm)

            
                Text("Open")
                    .font(.title3.bold())
                    .foregroundColor(Color.pink)
                    .frame(minWidth:80)
                
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
