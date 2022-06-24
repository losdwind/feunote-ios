//
//  SocialAbstract.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI

struct SocialAbstractView: View {
    private var analytics:[Analytics] = analyticsData
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
        VStack(alignment:.leading){
            Text("Activeness")
                .font(.title.bold())
                .foregroundColor(.accentColor)
            
            Text("Messages in Squad")
                .font(.callout)
                .foregroundColor(.gray.opacity(0.2))
            BarGraph(analytics: analytics)
        }
        }
        .padding()

    }
}

struct SocialAbstract_Previews: PreviewProvider {
    static var previews: some View {
        SocialAbstractView()
            .previewLayout(.sizeThatFits)
    }
}
