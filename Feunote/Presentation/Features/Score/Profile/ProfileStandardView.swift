//
//  ProfileStandardView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/29.
//

import SwiftUI

import Kingfisher

struct ProfileStandardView: View {
    @ObservedObject var profilevm:ProfileViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 30){
            
//            AsyncImage(url: URL(string: profilevm.user.profileImageUrl ?? "")) { image in
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 80, height: 80)
//                    .padding(4)
//                    .background(.white,in: Circle())
//                    .background(
//                        Circle()
//                            .stroke(.black,lineWidth: 4)
//                    )
//
//            } placeholder: {
//                Image("animoji1")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 80, height: 80)
//                    .padding(4)
//                    .background(.white,in: Circle())
//                    .background(
//                        Circle()
//                            .stroke(.black,lineWidth: 4)
//                    )
//            }
            
            
            KFImage(URL(string: profilevm.user.avatarURL))
                .placeholder {
                    // Placeholder while downloading.
                    Image(systemName: "arrow.2.circlepath.circle")
                        .font(.largeTitle)
                        .opacity(0.3)
                }
                .resizable()
                .frame(width: 80, height: 80)
                .padding(4)
                .background(.white,in: Circle())
                .background(
                    Circle()
                        .stroke(.black,lineWidth: 4)
                )
            
            VStack(alignment: .leading, spacing: 10){
                Text(profilevm.user.nickName )
                    .font(.title2)
                    .foregroundColor(.accentColor)
                
                //                    Text(AuthViewModel.shared.currentUser?.email ?? "aijieshu@figurich.com" )
                //                        .font(.footnote)
                

                HStack(alignment: .center, spacing: 20){
                    Image("score")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(4)
                        .background(.white,in: Circle())
                    Text("537")
                        .font(.footnote)
                        .foregroundColor(Color.pink)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .stroke(.pink,lineWidth: 1)
                )
                
                
                
                
            }
        }
    }
}


struct ProfileStandardView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileStandardView(profilevm: ProfileViewModel())
    }
}
