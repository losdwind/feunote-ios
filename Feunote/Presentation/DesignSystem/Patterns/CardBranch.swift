//
//  Cards.swift
//  BricksUI
//
//  Created by Samuel Kebis on 11/05/2020.
//  Copyright © 2020 Fabio Staiano. All rights reserved.
//

import SwiftUI

struct EWCardBranch: View {
    var coverImage: UIImage?
    var title: String?
    var description: String?
    var author:FeuUser?
    var members:[FeuUser]?
    var numOfLikes: Int?
    var numOfDislikes: Int?
    var numOfSubs: Int?
    var numOfShares: Int?
    var numOfComments: Int?

    
    var body: some View {
        VStack(alignment:.leading, spacing: .ewPaddingVerticalLarge){
            VStack(alignment: .leading, spacing: 0) {
                Image(uiImage: (coverImage ?? UIImage(systemName: "person.fill"))!)
                    .aspectRatio(contentMode: .fit)
                VStack(alignment:.leading, spacing: .ewPaddingVerticalDefault){
                    Text(title ?? "Untitled")
                        .font(Font.ewHeadline)
                        .lineLimit(1)
                    
                    Text(description ?? "No description")
                        .font(Font.ewBody)
                        .foregroundColor(Color.ewGray900)
                        .lineLimit(3)
                }
                
            }
            .cornerRadius(.ewCornerRadiusDefault)
            
            if author != nil, members != nil {
                
                // combine the author's avatarURL with each member's avatarURL
                EWAvatarGroup(images: [author!.avatarImage] + members!.map{$0.avatarImage} as! [UIImage], style: .small)
            }
            
            if numOfLikes != nil, numOfSubs != nil, numOfShares != nil, numOfComments != nil {
                HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge){
                    Label(String(numOfLikes!), image:"like")
                    Label(String(numOfSubs!), image:"rate-full")
                    Label(String(numOfShares!), image:"replay-2")
                    Label(String(numOfComments!), image:" messaging")
                }
            }
            
        }
        .cornerRadius(.ewCornerRadiusLarge)
        .padding(.horizontal, .ewPaddingHorizontalLarge)
        .padding(.vertical, .ewPaddingVerticalLarge)
        

    }
}


struct Cards_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            EWCardBranch(coverImage: nil, title: "Make a Nice Chart", description: "We make charts with science inside", author: FeuUser(username: "nameless", email: "s112312@gmail.com", avatarImage: UIImage(systemName: "person.fill")!, nickName: "KK"), members: [FeuUser(username: "nameless", email: "s112312@gmail.com", avatarImage: UIImage(systemName: "person.fill")!, nickName: "KK"),FeuUser(username: "", email: "s112312@gmail.com", avatarImage: UIImage(systemName: "person.fill")!, nickName: "KK")], numOfLikes: 117, numOfSubs:112, numOfShares: 11, numOfComments:10)
            
            EWCardBranch(coverImage: nil, title: "Make a Nice Chart", description: "We make charts with science inside", author: FeuUser(username: "nameless", email: "s112312@gmail.com", avatarImage: UIImage(systemName: "person.fill")!, nickName: "KK"), members: [FeuUser(username: "", email: "s112312@gmail.com", avatarImage: UIImage(systemName: "person.fill")!, nickName: "KK"),FeuUser(username: "nameless", email: "s112312@gmail.com", avatarImage: UIImage(systemName: "person.fill")!, nickName: "KK")])
            
            EWCardBranch(title: "Make a Nice Chart", description: "We make charts with science inside")
            
        }
        .previewLayout(.fixed(width: 300, height: 330))
    }
}
