//
//  BranchView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/28.
//

import SwiftUI

import Firebase
import FirebaseFirestoreSwift

struct BranchCardView: View {
    var branch:Branch
    

    var body: some View {
        
        VStack(alignment:.leading){
            
            HStack(alignment: .top){
                
                VStack(alignment: .leading,spacing: 12){
                    
                    //                    Text(meeting.timing.formatted(date: .numeric, time: .omitted))
                    
                    
                    Text(branch.title)
                        .font(.title2.bold())
                        .lineLimit(2)
                    
                    Text(branch.description)
                        .font(.footnote)
                        .lineLimit(3)
                    
                    Text(branch.timeSlot)
                        .font(.caption.bold())
                        .foregroundColor(Color.pink)
                        .padding(.horizontal, 8)
                        .background(.white.opacity(0.9),in: Capsule())
                        
                    
                }
                                
              
                
                
            }
            
            
            
            
            
            HStack(alignment:.center){
                    HStack{
                        ForEach(1...3,id: \.self){index in
                            
                            Image("animoji\(index)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .padding(4)
                                .background(.white,in: Circle())
                            // border...
                                .background(
                                    
                                    Circle()
                                        .stroke(.black,lineWidth: 1)
                                )
                        }

                }
                Spacer()
                
                
                
             
                    

                }
                
            }
        
        }
        
    
    
    
    func getColor(opentype: OpenType) -> Color{
        
        switch opentype {
            
        case .Public:
            return Color.green
        case .Private:
            return Color.gray.opacity(0.2)
        case .OnInvite:
            return Color.pink
        }
    }
}


struct StarsView: View {
    var rating: CGFloat
    var maxRating: Int = 5
    
    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<maxRating) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        
        stars.overlay(
            GeometryReader { g in
                let width = rating / CGFloat(maxRating) * g.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.pink)
                }
            }
                .mask(stars)
        )
            .foregroundColor(.gray)
    }
}

struct BranchCardView_Previews: PreviewProvider {
    @State static var branch:Branch = Branch(id: "", serverTimestamp: Timestamp(date:Date()), localTimestamp: Timestamp(date:Date()), ownerID: "", linkedItems: [], title: "This is a test for what", timeSlot: "Everyday 5~6PM", description: "In this branch we gonna test its permission issue and allow some other things. NOW STREAMING: Mark Zuckerberg and Facebook executives share their vision for the metaverse—the next…", openness: "Private")
    static var previews: some View {
        BranchCardView(branch: branch)
            .previewLayout(.sizeThatFits)
    }
}
