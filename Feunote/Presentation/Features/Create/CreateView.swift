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

            HStack(alignment: .top, spacing: .ewPaddingHorizontalDefault) {
                NavigationLink {
                    VStack{
                        SurveyCardsView()
                        Spacer()
                    }
                    .padding(.ewPaddingHorizontalDefault)

                } label: {
                    SurveyCard()
                }

                NavigationLink {
                    ScrollView(.vertical, showsIndicators: false){
                        LazyVStack(alignment: .leading, spacing: .ewPaddingVerticalDefault){
                            ForEach(PPCards, id: \.self) { card in
                                PPCardView(card: card, progress: Int.random(in: 0..<7))
                            }
                        }
                    }
                    .padding(.ewPaddingHorizontalDefault)

                } label: {
                    ChallengeCard()
                }

            }

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
