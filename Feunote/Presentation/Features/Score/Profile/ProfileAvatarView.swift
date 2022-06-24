//
//  ProfileSimpleView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/29.
//

import SwiftUI
import Kingfisher
struct ProfileAvatarView: View {
    
    var profileImageURL:String?
    
    
    var body: some View {
        
            
                KFImage(URL(string: profileImageURL ?? ""))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .background(Circle()
                                    .stroke(.black,lineWidth: 1))
                    .frame(width: 30, height: 30)
                    .cornerRadius(15)
                 
           
            
            
        }
    
}

struct ProfileSimpleView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileAvatarView(profileImageURL: nil)
    }
}
