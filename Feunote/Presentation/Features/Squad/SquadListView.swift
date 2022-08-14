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
            LazyVStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                ForEach(squadvm.fetchedParticipatedBranches, id: \.id) { branch in
                        SquadCardView(branch: branch)
                            .background(Color.ewGray50)
                            .cornerRadius(.ewCornerRadiusDefault)
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
