//
//  UserProgressView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/31.
//

import SwiftUI

struct UserProgressView: View {
    var title:String
    var color: Color
    var image:String
    var progress: CGFloat
    
    
    
    var body: some View {
        UserProgress(title: title, color: color, image: image, progress: progress)

    }
    
    
    @ViewBuilder
    func UserProgress(title: String,color: Color,image: String,progress: CGFloat)->some View{
        
        HStack{
            
            Image(systemName: image)
                .font(.title2)
                .foregroundColor(color)
                .padding(10)
                .background(
                
                    ZStack{
                        
                        Circle()
                            .stroke(Color.gray.opacity(0.3),lineWidth: 2)
                        
                        Circle()
                            .trim(from: 0, to: progress / 100)
                            .stroke(color,lineWidth: 2)
                            .rotationEffect(.init(degrees: -90))
                    }
                )
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text("\(Int(progress))%")
                    .fontWeight(.bold)
                
                Text(title)
                    .font(.caption2.bold())
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity,alignment: .center)
    }
}


struct UserProgressView_Previews: PreviewProvider {
    static var previews: some View {
        UserProgressView(title: "Man", color: Color("LightBlue"), image: "person", progress: 68)
    }
}
