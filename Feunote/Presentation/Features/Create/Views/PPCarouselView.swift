//
//  PPCarouselView.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/19.
//

import SwiftUI

struct PPCarouselView: View {
    var cards:[PPCard]
    
    var body: some View {
            TabView {
                ForEach(cards, id:\.self) { card in
                    PPCardView(card: card)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .indexViewStyle(.page(backgroundDisplayMode: .never))

        
    }
    
}

struct PPCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        PPCarouselView(cards: PPCards)
    }
}
