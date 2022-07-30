//
//  SquadSearchView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/25.
//

import SwiftUI

struct SquadSearchView: View {
    @EnvironmentObject var squadvm:SquadViewModel
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Text("Squad Search")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    SearchView(input: $squadvm.searchInput)
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}

struct SquadSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SquadSearchView()
    }
}
