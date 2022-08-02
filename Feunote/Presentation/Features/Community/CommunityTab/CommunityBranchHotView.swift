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
            RefreshableView {
                Group {
                    CommunityTilesView()
                    CommunityBranchListView()
                }
            }
        }
        .refreshable {
            await communityvm.getPublicBranches(page: 1)
        }
    }
}

struct CommunityBranchHottestView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityBranchHotView()
    }
}
