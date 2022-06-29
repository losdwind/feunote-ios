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
                Image(uiImage: avatarImage ?? UIImage(systemName: "person.fill")!)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(.ewCornerRadiusDefault)
                VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault){
                    Text(name ?? "").font(Font.ewHeadline).lineLimit(1)
                    Label(address ?? "Blank", image: "globe")
                    Label(birthday?.description ?? "Not Available", image: "globe")
                }
            }
            
            Text(description ?? "" )
                .font(.ewBody)
                .foregroundColor(.ewGray900)
            
            HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge) {
                Button {
                    
                } label: {
                    Image("phone")
                }
                
                Button {
                    
                } label: {
                    Image("messaging")
                }
                
                Button {
                    
                } label: {
                    Image("twitter")
                }
                
                Button {
                    
                } label: {
                    Image("linkedin")
                }
                
                

            }
            
        }
    }
}

struct EWCardPerson_Previews: PreviewProvider {
    static var previews: some View {
        EWCardPerson(name: "Emma Dorsey", avatarImage: UIImage(systemName: "person.fill"), address: "United Kingdom (UK)", birthday: Date(timeIntervalSince1970: 100), description: "She is a pretty girl with great sense of humor and has a lot of travelling experience. Especially, she is very familliar with France, Norway, US because she lives in these countries more than 5 yrs. So if has any related questions, just call her for info.")
        
        EWCardPerson(name: "Emma Dorsey", description: "She is a pretty girl with great sense of humor and has a lot of travelling experience. Especially, she is very familliar with France, Norway, US because she lives in these countries more than 5 yrs. So if has any related questions, just call her for info.")
    }
}
