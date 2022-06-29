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
    var images: [UIImage]?
    var audios: [NSData]?
    var videos: [NSData]?
    var updatedAt: Date?
    var action:()->Void
    
    var body: some View {
        VStack(alignment:.leading, spacing: .ewPaddingVerticalDefault){
            
            HStack{
                Text(updatedAt?.description ?? "date display error")
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
            if images != nil {
                ForEach(images!, id:\.self){
                    image in
                        Image(uiImage: image)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                }
                
//                if momentvm.images.isEmpty == false{
//
//                    ImageGridDataView(images: momentvm.images)
//                }
            }
            
            // MARK: - Todo Implement Audio Reader
            if audios != nil {
                ForEach(audios!, id:\.self){
                    audio in
                }
            }
            
            // MARK: - Todo Implement Video Player

            if videos != nil {
                ForEach(videos!, id:\.self){
                    video in
                    
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
        EWCardMoment(title: "here is the title", content: "here is the description", images: [], audios: [], videos: [], updatedAt: Date.now, action: {})
        EWCardMoment(updatedAt: Date.now, action: {print("button cliked")})

    }
}
