//
//  SquadView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/18.
//

import SwiftUI

struct SquadView: View {
    @EnvironmentObject var squadvm:SquadViewModel
    var body: some View {
            SquadListView()
                .task {
                    await squadvm.getParticipatedBranches(page: 1)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image("search")
                            .foregroundColor(.ewBlack)
                            .frame(width: 14, height: 14)
                    }

                }
                .navigationTitle("Squad")
                .navigationBarTitleDisplayMode(.inline)



    }
}

struct SquadView_Previews: PreviewProvider {
    static var previews: some View {
        SquadView()
    }
}
