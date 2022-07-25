//
//  SquadSearchView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/25.
//

import SwiftUI

struct SquadSearchView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Text("Squad Search")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image("arrow-left-2")
                            .foregroundColor(.ewBlack)
                    }
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
