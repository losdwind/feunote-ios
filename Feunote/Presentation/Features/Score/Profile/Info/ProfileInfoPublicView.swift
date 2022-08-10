//
//  ProfileInfoPublicView.swift
//
//  Created by Losd wind on 2021/10/29.
//

import SwiftUI

import Kingfisher

struct ProfileInfoPublicView: View {
    
    var user:AmplifyUser
    
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
            HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge){

                PersonAvatarView(imageKey: user.avatarKey, style: .medium)
                
                VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault){
                    Text(user.username ?? "N.A.").font(Font.ewHeadline).lineLimit(1)
                        .frame(alignment:.leading)
                    if user.address != nil {
                        Label(user.address!, image: "globe")
                            .font(.ewFootnote)
                            .foregroundColor(.ewGray900)
                            .frame(alignment:.leading)
                            .lineLimit(1)
                    }
                    if user.birthday != nil {
                        Label(user.birthday!.foundationDate.formatted().description, image: "id-card")
                            .font(.ewFootnote)
                            .foregroundColor(.ewGray900)
                            .frame(alignment:.leading)
                            .lineLimit(1)
                    }
                    
                }
                .frame(maxWidth:.infinity,alignment:.leading)
                
                
            }
            
            Text(user.bio ?? "Empty")
                .font(.ewBody)
                .foregroundColor(.ewGray900)
                .frame(alignment: .topLeading)
            
            
            HStack(alignment: .center, spacing: 20){
                Image("Wellbeing Score")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 20)
                    .foregroundColor(.ewGray900)
                    .background(Color.ewSecondary100,in: RoundedRectangle(cornerRadius: .ewCornerRadiusSmall))
                Text("537")
                    .font(.ewHeadline)
                    .foregroundColor(.ewSecondaryBase)
            }
        }
        .padding(.horizontal, .ewPaddingHorizontalDefault)
        .padding(.vertical, .ewPaddingVerticalDefault)
        .background(Color.ewGray50, in:RoundedRectangle(cornerRadius: .ewCornerRadiusDefault))
        
        
        
        
    }
    
}



struct ProfileStandardView_Previews: PreviewProvider {
    @EnvironmentObject static var profilevm:ProfileViewModel
    static var previews: some View {
        ProfileInfoPublicView(user: profilevm.user)
    }
}
