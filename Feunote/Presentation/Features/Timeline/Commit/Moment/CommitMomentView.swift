//
//  CardMoment.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/8.
//

import SwiftUI

struct CommitMomentView: View {
    var moment:AmplifyCommit
    var body: some View {
        VStack(alignment:.leading, spacing: .ewPaddingVerticalDefault){
            
            HStack{
                Text(moment.updatedAt?.foundationDate.formatted().description ?? "date display error")
                    .font(Font.ewFootnote)
                
                Spacer(minLength: .ewPaddingVerticalLarge)
                
                Button {

                } label: {
                    Image("more-hor")
                }

                
            }
            .foregroundColor(.ewGray100)
            
            if moment.titleOrName != nil {
                Text(moment.titleOrName!)
                        .font(Font.ewHeadline)
                        .foregroundColor(Color.ewGray900)
                        .lineLimit(1)
            }
            
            if moment.description != nil {
                Text(moment.description!)
                    .font(Font.ewBody)
                    .foregroundColor(Color.ewGray900)
            }
           
            // MARK: - Todo Wrap the AsyncImage to Component
            if moment.photoKeys != nil {
                CommitPhotosView(photoKeys: moment.photoKeys!)
            }

            
            // MARK: - Todo Implement Audio Reader
            if moment.audioKeys != nil {
                ForEach(moment.audioKeys!, id:\.self){
                    audio in
                }
            }
            
            // MARK: - Todo Implement Video Player

            if moment.videoKeys != nil {
                ForEach(moment.videoKeys!, id:\.self){
                    video in
                    
                }
            }
            
        }
        .padding(.horizontal, .ewPaddingHorizontalDefault)
        .padding(.vertical, .ewPaddingVerticalDefault)
        .background(Color.ewGray50)
        .cornerRadius(.ewCornerRadiusDefault)

    }
}

struct CardMoment_Previews: PreviewProvider {
    static var previews: some View {
        CommitMomentView(moment: AmplifyCommit(commitType: .moment))

    }
}
