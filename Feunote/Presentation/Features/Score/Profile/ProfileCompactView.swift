//
//  ProfileView.swift
//  Beliski-Firebase
//
//  Created by Wind Losd on 2021/9/17.
//

import SwiftUI
import Kingfisher

struct ProfileCompactView: View {
    
    @ObservedObject var profilevm:ProfileViewModel
    
    var body: some View {
        VStack{
            ProfileStandardView(profilevm: profilevm)
        
            Divider().frame(width: 150, alignment: .center)
                .padding()
        
            OpenStatsBarView(profilevm: profilevm)
            
        }
        .padding()

            
    }
}

struct ProfileView_Previews: PreviewProvider{
    static var previews: some View {
        ProfileCompactView(profilevm: ProfileViewModel())
            .previewLayout(.sizeThatFits)
        
    }
}


