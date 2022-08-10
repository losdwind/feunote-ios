//
//  SquadCardView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import SwiftUI

struct SquadCardView: View {
//    var branchTeamMembers:[AmplifyUser]
    var branchTeamName: String
    var branchRecentMessage: AmplifyAction

    var body: some View {
        VStack(alignment: .leading, spacing: .ewCornerRadiusDefault) {
            HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
                EWAvatarGroup(avatars: [UIImage(named: "demo-person-1")!, UIImage(named: "demo-person-2")!, UIImage(named: "demo-person-3")!], style: .medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(branchTeamName)
                    .font(.headline)
                    .foregroundColor(.ewBlack)
                    .lineLimit(1)
            }

            HStack {
                Text(branchRecentMessage.owner ?? "")
                    .font(.subheadline)
                    .foregroundColor(.ewBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(branchRecentMessage.createdAt?.foundationDate.formatted(date: .omitted, time: .shortened).description ?? Date.now.formatted(date: .omitted, time: .shortened).description)
            }

            Text(branchRecentMessage.content ?? "")
                .font(.ewFootnote)
                .foregroundColor(.ewGray900)
        }
        .padding()
    }
}

struct SquadCardView_Previews: PreviewProvider {
    static var previews: some View {
        SquadCardView(branchTeamName: "Figurich K19", branchRecentMessage: fakeActionMessage1)
    }
}
