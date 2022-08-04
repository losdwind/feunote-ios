//
//  CommunityAbstractView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI

struct CommunityAbstractView: View {
    
    
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
                
                
                Text("Your Community: Gender Ratio ")
                    .fontWeight(.semibold)
                
                HStack(alignment:.center){

                }
                
            }
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
