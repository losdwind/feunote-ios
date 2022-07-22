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
                    EWAvatarImage(image: avatarImage!, style: .medium)
                }

                    VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault){
                        Text(name ?? "No Name").font(Font.ewHeadline).lineLimit(1)
                            .frame(alignment:.leading)
                        if address != nil {
                            Label(address!, image: "globe")
                                .font(.ewFootnote)
                                .foregroundColor(.ewGray900)
                                .frame(alignment:.leading)
                                .lineLimit(1)
                        }
                        if birthday != nil {
                            Label(birthday!.formatted().description, image: "id-card")
                                .font(.ewFootnote)
                                .foregroundColor(.ewGray900)
                                .frame(alignment:.leading)
                                .lineLimit(1)
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
        .padding(.horizontal, .ewPaddingHorizontalDefault)
        .padding(.vertical, .ewPaddingVerticalDefault)
        .background(Color.ewGray50)
        .cornerRadius(.ewCornerRadiusDefault)
    }
}

struct EWCardPerson_Previews: PreviewProvider {
    static var previews: some View {
        EWCardPerson(name: fakeAmplifyPerson1.titleOrName, avatarImage: UIImage(named: "demo-person-1"), address: fakeAmplifyPerson1.personAddress, birthday: fakeAmplifyPerson1.personBirthday?.foundationDate, description: fakeAmplifyPerson1.description)
            .previewLayout(.sizeThatFits)
    }
}
