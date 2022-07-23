//
//  SquadListView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/23.
//

import SwiftUI

struct SquadListView: View {
    @EnvironmentObject var squadvm:SquadViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(squadvm.fetchedParticipatedBranches.indices, id: \.self) { index in
                    NavigationLink {
                        SquadChatView(branchID: squadvm.fetchedParticipatedBranches[index].id)
                    } label: {
                        SquadCardView(branchTeamName: "Smoke Weed", branchRecentMessage: fakeActionMessage2)
                            .background(index % 2 == 0 ? Color.ewGray50 : Color.ewWhite)
                    }


                }
            }
        }
    }
}

struct SquadListView_Previews: PreviewProvider {
    static var previews: some View {
        SquadListView()
    }
}
