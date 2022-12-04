//
//  CommunityBranchSubscribedView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/25.
//

import SwiftUI

struct CommunityBranchSubscribedView: View {
    @EnvironmentObject var communityvm: CommunityViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if communityvm.fetchedSubscribedBranches.count == 0 {
                Text("Empty Subscribed Branches")
            } else {
                BranchListView(branches: $communityvm.fetchedSubscribedBranches)
            }
        }
        .task {
            await communityvm.getSubscribedBranches(page: 0)
        }
    }
}

struct CommunityBranchSubscribed_Previews: PreviewProvider {
    static var previews: some View {
        CommunityBranchSubscribedView()
    }
}
