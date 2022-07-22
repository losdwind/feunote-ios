//
//  SurveyView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/22.
//

import SwiftUI

struct SurveyView: View {
    var body: some View {
        VStack(alignment:.leading, spacing: .ewPaddingVerticalDefault) {
            Label {
                Text("Surveys")
                    .font(.ewHeadline)
                
            } icon: {
                Image(systemName: "doc.append")
            }
            
//            ScrollView(.horizontal, showsIndicators: false){
//                HStack{
//                    NavigationLink {
//                        VIAView()
//                    } label: {
//                        CardView(image: "VIA", title: "VIA Character \nStrength Survey", color: Color.white)
//                    }
//                    
//                    NavigationLink {
//                        MBTIView()
//                    } label: {
//                        CardView(image: "mbti", title: "Myers-Briggs \nType Indicator", color: Color.white)
//                    }
//                    
//                    NavigationLink {
//                        BigFiveView()
//                    } label: {
//                        CardView(image: "bigfive", title: "Big Five \npersonality traits", color: Color.white)
//                    }
//                }
//                
//            }
            
        }
    }
}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyView()
    }
}
