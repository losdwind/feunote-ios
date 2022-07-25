//
//  CommunityBranchHotView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/25.
//

import SwiftUI

struct CommunityBranchHotView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            CommunityTilesView()
            CommunityBranchListView()
        }
    }
}

struct CommunityBranchHottestView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityBranchHotView()
    }
}
