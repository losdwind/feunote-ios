//
//  AuthContainerView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import SwiftUI


struct AuthContainerView<Content: View>: View {
    private let title: String
    private let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        ZStack {
            Color.ewGray100.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 15) {
                Text(title)
                    .font(.system(size: 30, weight: .bold))
                    .padding(.bottom, 10)
                content
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2)
            )
            .padding()
        }
    }
}

struct AuthContainerView_Previews: PreviewProvider {
    static var previews: some View {
        AuthContainerView()
    }
}
