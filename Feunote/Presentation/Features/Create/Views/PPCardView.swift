//
//  PPCardView.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/19.
//

import SwiftUI

struct PPCardView: View {
    var card: PPCard

    var progress: Int

    var body: some View {

        // readmore
        NavigationLink {
            PPDetailView(currentCard: card)
        } label: {
            VStack(alignment: .leading, spacing: .ewPaddingHorizontalDefault) {
                Text(card.title)
                    .font(.ewHeadline)

                Text(card.description)
                    .font(.ewFootnote)
                    .foregroundColor(.ewGray900)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth:.infinity)

                HStack(spacing: 5) {
                    HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall) {
                        ForEach(1 ... 7, id: \.self) { i in
                            Button {
                                print("here has a button")
                            } label: {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .scaleEffect(0.6)
                                    .foregroundColor(i < (progress + 1) ? Color.white : Color.white)
                            }
                            .padding(2)
                            .foregroundColor(Color.white)
                            .background(i < (progress + 1) ? Color.ewSecondaryBase : Color.ewGray100, in: Circle())
                            .disabled(i != (progress + 1))
                            .frame(width:24)
                        }
                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)



                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(card.cardColor, in: RoundedRectangle(cornerRadius: 18))
        }

    }
}

struct PPCardView_Previews: PreviewProvider {
    static var previews: some View {
        PPCardView(card: PPCards[1], progress: 2)
    }
}
