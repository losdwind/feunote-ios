//
//  SearchView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/18.
//

import SwiftUI

struct SearchView: View {
    @Binding var input:String
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack{
            Text("Search Result")
                .font(.ewBody)
                .foregroundColor(.ewGray900)
        }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.ewHeadline)
                            .foregroundColor(.ewPrimaryBase)

                    }

                }
                ToolbarItem(placement: .principal) {
                    EWTextField(input: $input, icon: nil, placeholder: "Search")
                }
            }
            .navigationBarBackButtonHidden(true)
    }

}

struct SearchView_Previews: PreviewProvider {
    @State static var input = "here we go"
    static var previews: some View {
        SearchView(input: $input)
    }
}
