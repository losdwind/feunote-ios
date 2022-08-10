//
//  ProfileInfoPrivateView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/8.
//

import SwiftUI

struct StatsBarsView: View {
    @EnvironmentObject var profilevm: ProfileViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
            StatsBarPrivateView(profilevm: profilevm)

            StatsBarOpenView(profilevm: profilevm)
        }
    }
}

struct StatsBarsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsBarsView()
    }
}
