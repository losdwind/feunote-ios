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
            VStack(alignment: .leading, spacing: 20) {
                
                Text(card.title)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text(card.description)
                    .font(.body)
//                    .fontWeight(.semibold)
                    .lineLimit(3)
                    .frame(height: 70, alignment: .top)
                
                HStack(spacing:5) {

                        HStack(alignment: .center, spacing: 3){
//                            Color.red.frame(width: 10, height: 2)

                            ForEach(1...7, id: \.self){i in
                                Button {
                                    print("here has a button")
                                } label: {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                                }
                                .padding(5)
                                .foregroundColor(Color.white)
                                .background(i < (progress+1) ? Color.pink : Color.gray, in:Circle())
                                .disabled(i != (progress+1))
                            
                            }
                        }
                    
                    
                    
                    
                    Spacer()
                    // read more
                    NavigationLink {
                        PPDetailView(currentCard: card)
                    } label: {
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Read More")
                        }
                        .font(.system(size: 15, weight: .semibold))
                        // Moving To right without Spacers...
    //                    .frame(maxWidth: .infinity,alignment: .trailing)
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
