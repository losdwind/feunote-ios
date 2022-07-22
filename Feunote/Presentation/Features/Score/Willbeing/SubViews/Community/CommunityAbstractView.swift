//
//  CommunityAbstractView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI

struct CommunityAbstractView: View {
    
    private var analytics:[Analytics] = analyticsData
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20){
                Text("Your Country: United States")
                    .fontWeight(.semibold)
                
                Text("TBD.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .frame(height:200)
                    .frame(maxWidth: .infinity,alignment: .center)
                Text("Your District: Madison, Wisconsin")
                    .fontWeight(.semibold)
                Text("TBD.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .frame(height:200)
                    .frame(maxWidth: .infinity,alignment: .center)
                
                
                Text("Your Community: Startups ")
                    .fontWeight(.semibold)
                
                HStack(alignment:.center){
                    // Progress View...
                    UserProgressView(title: "Male", color: Color.blue, image: "person", progress: 79)
                    UserProgressView(title: "Female", color: Color.pink, image: "person", progress: 21 )
                    
                }
                
            }
            .navigationTitle("Statistics")
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding()
        
    }
}

struct CommunityAbstractView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityAbstractView()
    }
}
