//
//  LoadingButtonView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import SwiftUI

struct LoadingButtonView: View {
    let title: String
    let isLoading: Bool
    let action: () -> Void

    var body: some View {
        ZStack {
            Button(action: action) {
                HStack {
                    Spacer()
                    Text(title)
                        .foregroundColor(isLoading ? .ewSecondary300 : .white)
                        .padding(10)
                    Spacer()
                }
                .background(isLoading ? Color.ewSecondary300 : Color.ewSecondary700)
                .cornerRadius(5)
            }
            .disabled(isLoading)
            if isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
    }
}

struct LoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButtonView()
    }
}
