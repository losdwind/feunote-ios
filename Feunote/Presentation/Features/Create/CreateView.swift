//
//  CreateView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import SwiftUI

struct CreateView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
            VStack(alignment: .center, spacing: .ewPaddingVerticalLarge) {
                PPCarouselView(cards: PPCards)
                    .frame(height: 180, alignment: .center)

                SurveyCard()

                NewGridView()

                Spacer()
            }
            .padding()

    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
