//
//  CommunityTilesView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import SwiftUI

struct CommunityTilesView: View {
    var body: some View {
        VStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
            HStack(alignment: .top, spacing: .ewPaddingHorizontalDefault) {
                EWTile(title: "Study", description: "Oral Learner, Programming", backgroundColor: Color(hexString: "EDF7F9"))
                EWTile(title: "Hobby", description: "Running, Tennis, Board Game", backgroundColor: Color(hexString: "F6FAE0"))
            }
            
            HStack(alignment: .top, spacing: .ewPaddingHorizontalDefault) {
                EWTile(title: "Competition", description: "Give your idea, Win your bounty", backgroundColor: Color(hexString: "F7EEEB"))
                EWTile(title: "Startup", description: "Find the right Cofounder, Technician", backgroundColor: Color(hexString: "EDEBF8"))
            }
            
            HStack(alignment: .top, spacing: .ewPaddingHorizontalDefault) {
                EWTile(title: "Game", description: "Find team member for PUBG, League of Legend", backgroundColor: Color(hexString: "ECF0F8"))
                EWTile(title: "Creation", description: "Find the right Cofounder, Technician", backgroundColor: Color(hexString: "EDF7F9"))
            }
            
        }
        
    }
}

struct CommunityTilesView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityTilesView()
    }
}
