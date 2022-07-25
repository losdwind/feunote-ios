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
        NavigationView {
            SquadListView()
                .task {
                    await squadvm.getParticipatedBranches(page: 1)
                    await squadvm.getMessages()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            SquadSearchView()
                        } label: {
                            Image("search")
                        }
                    }

                    ToolbarItem(placement: .principal) {
                        Text("Squad (12)")
                            .font(.ewHeadline)
                            .foregroundColor(.ewBlack)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SquadView_Previews: PreviewProvider {
    static var previews: some View {
        SquadView()
    }
}
