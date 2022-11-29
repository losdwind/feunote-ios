//
//  CommunityBranchHotView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/25.
//

import SwiftUI

struct CommunityBranchHotView: View {
    @EnvironmentObject var communityvm: CommunityViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                CommunityTilesView()
                if communityvm.fetchedOpenBranches.count == 0 {
                    Text("Loading")

                    }else {
                        BranchListView(branches: $communityvm.fetchedOpenBranches)

                    }
            }

        }
    }

//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false) {
//            RefreshableView {
//                Group {
//                    CommunityTilesView()
//                    BranchListView(branches: communityvm.fetchedOpenBranches)
//                }
//            }
//        }
//        .refreshable {
//            await communityvm.getOpenBranches(page: 0)
//        }
//    }
}

struct CommunityBranchHottestView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityBranchHotView()
    }
}
