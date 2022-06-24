//
//  ProfileDetailView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/8.
//

import SwiftUI

struct ProfileDetailView: View {
    @ObservedObject var profilevm:ProfileViewModel
    
    var body: some View {
        VStack{
            HStack{
                Text("Private")
                    .font(.title3.bold())
                    .foregroundColor(Color.pink)
                    .frame(minWidth:80)
                
                Spacer()
                PrivateStatsBarView(profilevm: profilevm)
                
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(18)
            
            HStack{
                Text("Open")
                    .font(.title3.bold())
                    .foregroundColor(Color.pink)
                    .frame(minWidth:80)
                
                Spacer()
                OpenStatsBarView(profilevm: profilevm)
                
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(18)
            
        }
        .padding()
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(profilevm: ProfileViewModel())
    }
}
