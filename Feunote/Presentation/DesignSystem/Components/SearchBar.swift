//
//  SearchBar.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/26.
//

import SwiftUI

struct EWSearchBar: View {
    @Binding var input: String
    @FocusState private var isfocus: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
            EWTextField(input: $input, icon: Image("search"), placeholder: "Search")
                .focused($isfocus)
            if isfocus {
                Button {
                    withAnimation {
                        isfocus.toggle()
                        dismiss()
                    }
                } label: {
                    Text("Cancel")
                        .foregroundColor(.ewBlack)
                        .font(.ewHeadline)
                }
            }
        }
    }
}

struct EWSearchBar_Previews: PreviewProvider {
    @State static var input: String = ""
    static var previews: some View {
        EWSearchBar(input: $input)
            .padding()
    }
}
