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
    var author:String?
    var members:[String?]?
    var commits:[String?]?
    var numOfLikes: Int?
    var numOfDislikes: Int?
    var numOfSubs: Int?
    var numOfShares: Int?
    var numOfComments: Int?

    
    var body: some View {
        VStack(alignment:.leading, spacing: .ewPaddingVerticalLarge){
            if coverImage != nil {
                Image(uiImage: coverImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(.ewCornerRadiusDefault)
            }

            
                VStack(alignment:.leading, spacing: .ewPaddingVerticalDefault){
                    Text(title ?? "Untitled")
                        .font(Font.ewHeadline)
                        .lineLimit(1)
                    
                    Text(description ?? "No description")
                        .font(Font.ewBody)
                        .foregroundColor(Color.ewGray900)
                        .lineLimit(3)
                }
                
            
            
            if author != nil, members != nil {
                
                // combine the author's avatarURL with each member's avatarURL
//                EWAvatarGroup(images: [author!.avatarImage] + members!.map{$0.avatarImage} as! [UIImage], style: .small)
            }
            
            if numOfLikes != nil, numOfSubs != nil, numOfShares != nil, numOfComments != nil {
                HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall){
                    Label(formatNumber(numOfLikes!), image:"like")
                    Label(formatNumber(numOfSubs!), image:"rate-full")
                    Label(formatNumber(numOfShares!), image:"replay-2")
                    Label(formatNumber(numOfComments!), image:" messaging")
                }
                .font(.ewFootnote)
            }
            
        }
        .padding(.horizontal, .ewPaddingHorizontalDefault)
        .padding(.vertical, .ewPaddingVerticalDefault)
        .background(Color.ewGray50)
        .cornerRadius(.ewCornerRadiusDefault)
        

    }
}


struct Cards_Previews: PreviewProvider {
    
    static var fake = FeuBranch()

    static var previews: some View {
            
            EWCardBranch(coverImage: UIImage(named: "demo-picture-1") , title: fake.title, description: fake.description, author: fake.owner, members: fake.members, commits: fake.commits, numOfLikes: fake.numOfLikes, numOfDislikes: fake.numOfDislikes, numOfSubs: fake.numOfSubs, numOfShares: fake.numOfShares, numOfComments: fake.numOfComments)
        .task {
            do {
                self.fake = try await FakeViewDataMapper().branchDataTransformer(branch: fakeAmplifyBranch)
            } catch{}
            
        }
        .previewLayout(.fixed(width: 300, height: 330))
    }
}
