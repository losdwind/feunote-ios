//
//  CardPerson.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/9.
//

import SwiftUI

struct EWCardPerson: View {
    var name: String?
    var avatarImage: UIImage?
    var address: String?
    var birthday: Date?
    var description: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge){
            HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge){
                if avatarImage != nil {
                    Image(uiImage: avatarImage!)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120, alignment: .center)
                        .background(Color.ewGray100)
                        .cornerRadius(.ewCornerRadiusDefault)
                }

                    VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault){
                        Text(name ?? "No Name").font(Font.ewHeadline).lineLimit(1)
                            .frame(alignment:.leading)
                        if address != nil {
                            Label(address ?? "N.A", image: "globe")
                                .frame(alignment:.leading)
                        }
                        if birthday != nil {
                            Label(birthday?.formatted().description ?? "N.A", image: "id-card")
                                .frame(alignment:.leading)
                        }

                    }
                    .layoutPriority(1)
                    
                    Spacer()

                
            }
            
            Text(description ?? "No Description" )
                .font(.ewBody)
                .foregroundColor(.ewGray900)
                .frame(alignment: .topLeading)
            
            HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge) {
                Button {
                    
                } label: {
                    Image("phone")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20, alignment: .center)
                }
                
                Button {
                    
                } label: {
                    Image("messaging")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20, alignment: .center)

                }
                
                Button {
                    
                } label: {
                    Image("twitter")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20, alignment: .center)

                }
                
                Button {
                    
                } label: {
                    Image("linkedin")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20, alignment: .center)

                }

            }
            .frame(alignment: .leading)
            
        }
        .padding(.horizontal, .ewPaddingHorizontalLarge)
        .padding(.vertical, .ewPaddingVerticalLarge)
        .background(Color.ewGray50)
        .cornerRadius(.ewCornerRadiusDefault)
    }
}

struct EWCardPerson_Previews: PreviewProvider {
    static var previews: some View {
        EWCardPerson()
    }
}
