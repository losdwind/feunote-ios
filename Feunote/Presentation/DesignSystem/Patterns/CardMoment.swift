//
//  CardMoment.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/8.
//

import SwiftUI

struct EWCardMoment: View {
    var title: String?
    var content: String?
    var imageURLs: [String?]?
    var audioURLs: [String?]?
    var videoURLs: [String?]?
    var updatedAt: Date
    var action:()->Void
    
    var body: some View {
        VStack(alignment:.leading, spacing: .ewPaddingVerticalDefault){
            
            HStack{
                Text(updatedAt.formatted())
                    .font(Font.ewFootnote)
                
                Spacer(minLength: .ewPaddingVerticalLarge)
                
                Button {
                    action()
                } label: {
                    Image("more-hor")
                }

                
            }
            .foregroundColor(.ewGray100)
            
            if title != nil {
                Text(title!)
                        .font(Font.ewHeadline)
                        .lineLimit(1)
            }
            
            if content != nil {
                Text(content!)
                    .font(Font.ewBody)
                    .foregroundColor(Color.ewGray900)
                    .lineLimit(3)
            }
           
            // MARK: - Todo Wrap the AsyncImage to Component
            if imageURLs != nil {
                ForEach(imageURLs!, id:\.self){
                    imageURL in
                    if imageURL != nil {
                        AsyncImage(url: URL(string: imageURL!))
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                    }
                }
                
//                if momentvm.images.isEmpty == false{
//
//                    ImageGridDataView(images: momentvm.images)
//                }
            }
            
            // MARK: - Todo Implement Audio Reader
            if audioURLs != nil {
                ForEach(audioURLs!, id:\.self){
                    audioURL in
                    if audioURL != nil {
                        
                    }
                    
                }
            }
            
            // MARK: - Todo Implement Video Player

            if videoURLs != nil {
                ForEach(videoURLs!, id:\.self){
                    videoURL in
                    if videoURL != nil {
                        
                    }
                    
                }
            }
            
        }
        .cornerRadius(.ewCornerRadiusLarge)
        .padding(.horizontal, .ewPaddingHorizontalLarge)
        .padding(.vertical, .ewPaddingVerticalLarge)

    }
}

struct CardMoment_Previews: PreviewProvider {
    static var previews: some View {
        EWCardMoment(title: "Todo", content: "We have a lot to do", imageURLs: ["https://picsum.photos/200", "https://picsum.photos/200", "https://picsum.photos/200", "https://picsum.photos/200"], audioURLs: [], videoURLs: [], updatedAt: Date.now, action: {print("button cliked")})
        EWCardMoment(updatedAt: Date.now, action: {print("button cliked")})

    }
}
