//
//  ScoreView.swift
//  Beliski-Firebase
//
//  Created by Wind Losd on 2021/9/17.
//

import SwiftUI



struct WBScoreView: View {
    
    
    var wbScore:WBScore
    
    var body: some View {
        
            VStack(alignment:.center, spacing: .ewPaddingHorizontalLarge) {
                ScoreOverallView(wbScore: wbScore)
                ScoreReportView()
                ScoreComponentsView(wbScore: wbScore)
            }
        
    }
}

struct WBScoreView_Previews: PreviewProvider {
    static var previews: some View {
        WBScoreView(wbScore: WBScore(dateCreated: Date(), career: 145/200, social: 133/200, physical: 178/200, financial: 108/200, community: 89/200))
    }
}
