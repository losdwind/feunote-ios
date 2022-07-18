//
//  PPCardView.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/19.
//

import SwiftUI

struct PPCardView: View {
    
    var card:PPCard
    
    var progress:Int = 2
    
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingHorizontalDefault) {
                
                Text(card.title)
                    .font(.ewHeadline)
                
                Text(card.description)
                    .font(.ewFootnote)
                    .lineLimit(3)
                
                HStack(spacing:5) {

                    HStack(alignment: .center, spacing:.ewPaddingHorizontalSmall){
                            ForEach(1...7, id: \.self){i in
                                Button {
                                    print("here has a button")
                                } label: {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(i < (progress+1) ? Color.white : Color.white)
                                }
                                .padding(4)
                                .foregroundColor(Color.white)
                                .background(i < (progress+1) ? Color.ewSecondaryBase : Color.ewGray100, in:Circle())
                                .disabled(i != (progress+1))
                            
                            }
                        }
                    
                    
                    
                    
                    Spacer()
                    // read more
                    NavigationLink {
                        PPDetailView(currentCard: card)
                    } label: {
                        Image("info")
                    }
                    
                }
               
            }
                
            .padding(.horizontal,20)
            .padding(.vertical, 15)
            .background(card.cardColor, in: RoundedRectangle(cornerRadius: 18))
            
        
    }
}

struct PPCardView_Previews: PreviewProvider {
    static var previews: some View {
        PPCardView(card: PPCards[0])
    }
}
