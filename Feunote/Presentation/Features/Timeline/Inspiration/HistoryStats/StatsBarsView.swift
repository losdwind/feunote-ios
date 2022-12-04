//
//  ProfileInfoPrivateView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/8.
//

import SwiftUI

struct StatsBarsView: View {
    @EnvironmentObject var profilevm: ProfileViewModel
    @EnvironmentObject var timelinevm:TimelineViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {

            HStack(alignment: .center) {

                // MARK: - No.moments

                StatsBarEntryView(number: timelinevm.fetchedOwnedCommits.filter{$0.commitType == CommitType.moment}.count, text: "Moments")

                // MARK: - No. Completion/ Todos

                StatsBarEntryView(number: timelinevm.fetchedOwnedCommits.filter{$0.commitType == CommitType.todo}.count, text: "Todos")

                // MARK: - No. Persons

                StatsBarEntryView(number: timelinevm.fetchedOwnedCommits.filter{$0.commitType == CommitType.person}.count, text: "Persons")
            }


            HStack(alignment: .center) {

                // MARK: LIKES

                StatsBarEntryView(number:profilevm.currentUser?.actions?.filter{$0.actionType == ActionType.like.rawValue}.count ?? 0, text: "Likes")

                // MARK: Subs

                StatsBarEntryView(number: profilevm.currentUser?.actions?.filter{$0.actionType == ActionType.sub.rawValue}.count ?? 0, text: "Subs")

                // MARK: Messages

                StatsBarEntryView(number:  profilevm.currentUser?.messages?.count ?? 0, text: "Msgs.")
            }
        }
    }
}

struct StatsBarsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsBarsView()
    }
}
