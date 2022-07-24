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
                ForEach(squadvm.fetchedParticipatedBranches, id: \.id) { branch in
                    NavigationLink {
                        SquadChatView(branch: branch, messages:[fakeActionMessage1, fakeActionMessage2])
                    } label: {
                        SquadCardView(branchTeamName: branch.squadName ?? "Cool Fishes", branchRecentMessage: fakeActionMessage2)
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