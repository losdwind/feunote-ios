//
//  SquadListView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/23.
//

import SwiftUI

struct SquadListView: View {
    @EnvironmentObject var squadvm: SquadViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(squadvm.fetchedParticipatedBranches, id: \.id) { branch in
                    NavigationLink {
                        SquadChatView(branch: branch)
                    } label: {
                        SquadCardView(branchTeamName: branch.squadName ?? "No Name", branchRecentMessage: fakeActionMessage2)
                            .background(Color.ewGray50)
                            .cornerRadius(.ewCornerRadiusDefault)
                    }
                }
            }
            .padding()
        }
    }
}

struct SquadListView_Previews: PreviewProvider {
    static var previews: some View {
        SquadListView()
    }
}
