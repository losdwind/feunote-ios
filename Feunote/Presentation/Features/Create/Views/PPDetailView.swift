//
//  PPDetailView.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/19.
//

import SwiftUI

struct PPDetailView: View {
    var currentCard: PPCard
    @Namespace var animation

    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Rectangle()
                .fill(currentCard.cardColor)
                .matchedGeometryEffect(id: currentCard.id, in: animation)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 15) {
//                    Text(currentCard.date)
//                        .font(.callout)
//                        .fontWeight(.semibold)
//                        .padding(.top)

                Text(currentCard.title)
                    .font(.title.bold())


                ScrollView(.vertical, showsIndicators: false) {
                    // Sample Content...
                    Text(currentCard.detail)
                        .kerning(1.1)
                        .lineSpacing(8)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 10)
                }
            }
            .foregroundColor(.ewBlack)
            .padding()
            // Moving view to top Without Any Spacers..
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PPDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PPDetailView(currentCard: PPCard())
    }
}
