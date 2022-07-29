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
    var privacyType:PrivacyType
    var title: String?
    var description: String?
    var memberNames:[String]?
    var memberAvatars: [UIImage]?
    var numOfLikes: Int?
    var numOfDislikes: Int?
    var numOfSubs: Int?
    var numOfShares: Int?
    var numOfComments: Int?
    var likeAction: () -> Void = {}
    var dislikeAction: () -> Void = {}
    var subAction: () -> Void = {}
    var shareAction: () -> Void = {}
    var commentAction:() -> Void = {}



    
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
                
            
            
            if memberNames != nil, memberAvatars != nil, memberAvatars?.count == memberNames?.count {
                
                // combine the author's avatarURL with each member's avatarURL
//                EWAvatarGroup(images: [author!.avatarImage] + members!.map{$0.avatarImage} as! [UIImage], style: .small)
                EWAvatarGroup(images: memberAvatars!, style: .small)
            }
            
            if privacyType == .open {
                HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall){
                    Button {
                        likeAction()
                    } label: {
                        Label(formatNumber(numOfLikes ?? 0), image:"like")
                    }
                    
                    Button {
                        subAction()
                    } label: {
                        Label(formatNumber(numOfSubs ?? 0), image:"rate-full")
                    }

                    Button {
                        shareAction()
                    } label: {
                        Label(formatNumber(numOfShares ?? 0), image:"replay-2")
                    }

                    Button {
                        commentAction()
                    } label: {
                        Label(formatNumber(numOfComments ?? 0), image:"messaging")

                    }
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
    
    static var fake1 = FeuBranch()
    static var fake2 = FeuBranch()

    static var previews: some View {
        
        VStack{
            EWCardBranch(coverImage: UIImage(named: "demo-picture-1"), privacyType: fake1.privacyType, title: fake1.title, description: fake1.description, memberNames: nil, memberAvatars: nil, numOfLikes: fake1.numOfLikes, numOfDislikes: fake1.numOfDislikes, numOfSubs: fake1.numOfSubs, numOfShares: fake1.numOfShares, numOfComments: fake1.numOfComments)
        

            
            EWCardBranch(coverImage: UIImage(named: "demo-picture-1"), privacyType: fake2.privacyType, title: fake2.title, description: fake2.description, memberNames: nil, memberAvatars: nil, numOfLikes: fake2.numOfLikes, numOfDislikes: fake2.numOfDislikes, numOfSubs: fake2.numOfSubs, numOfShares: fake2.numOfShares, numOfComments: fake2.numOfComments)
            

        }
        .task {
            do {
                self.fake1 = try await FakeViewDataMapper().branchDataTransformer(branch: fakeAmplifyBranchPrivate)
                self.fake2 = try await FakeViewDataMapper().branchDataTransformer(branch: fakeAmplifyBranchOpen1)
            } catch{}
            
        }
        .previewLayout(.fixed(width: 300, height: 330))
    }
}
