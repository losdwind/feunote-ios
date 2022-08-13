//
//  SquadView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/18.
//

import SwiftUI

struct SquadView: View {
    @EnvironmentObject var squadvm: SquadViewModel
    var body: some View {
        SquadListView()
            .task {
                await squadvm.getParticipatedBranches()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SearchView(input: $squadvm.searchInput)
                    } label: {
                        Image("search")
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text("Squad")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.ewHeadline)
                        .foregroundColor(.ewBlack)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct SquadView_Previews: PreviewProvider {
    static var previews: some View {
        SquadView()
    }
}
