//
//  CommunityBranchListView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import SwiftUI

struct CommunityBranchListView: View {
    @EnvironmentObject var communityvm:CommunityViewModel
    var body: some View {
            LazyVStack(alignment: .center, spacing: .ewPaddingVerticalDefault){
                ForEach(communityvm.fetchedFilteredBranches, id: \.id) { branch in
                    
                    NavigationLink {
                        BranchLinkedItemsView(branch: branch)
                    } label: {
                        EWCardBranch(coverImage:nil, privacyType:branch.privacyType, title: branch.title, description: branch.description, numOfLikes: branch.numOfLikes, numOfDislikes: branch.numOfDislikes, numOfSubs: branch.numOfSubs, numOfShares: branch.numOfShares, numOfComments: branch.numOfComments)
                        
                    }
                }
                .task {
                    await communityvm.getPublicBranches(page: 1)
                }
                
            }

    }
    
}

struct CommunityBranchListView_Previews: PreviewProvider {

    static var previews: some View {
        CommunityBranchListView()
    }
}
