//
//  ProfileView.swift
//  Beliski-Firebase
//
//  Created by Wind Losd on 2021/9/17.
//

import SwiftUI
import Kingfisher

struct ProfileCompactView: View {
    
    @EnvironmentObject var profilevm:ProfileViewModel
    
    var body: some View {
        VStack{
            ProfileInfoPublicView(user: profilevm.user)
        
            Divider().frame(width: 150, alignment: .center)
                .padding()
        
            StatsBarOpenView(profilevm: profilevm)
            
        }
        .padding()

            
    }
}

struct ProfileView_Previews: PreviewProvider{
    static var previews: some View {
        ProfileCompactView()
            .previewLayout(.sizeThatFits)
        
    }
}


