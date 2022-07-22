//
//  ScoreComponentsView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/22.
//

import SwiftUI

struct ScoreComponentsView: View {
    var wbScore:WBScore
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault){
            Label {
                Text("Components")
                    .font(.ewHeadline)
            } icon: {
                Image(systemName: "square.stack.3d.forward.dottedline.fill")
            }
            
            
            NavigationLink {
                CareerAbstractView()
            } label: {
                ScoreComponentCard(iconName: "case", name: "Career", description: "Career metrics measure your completion rate of todos and job attributes.", score: wbScore.career)
            }
            
            NavigationLink {
                SocialAbstractView()
            } label: {
                ScoreComponentCard(iconName: "point.3.connected.trianglepath.dotted", name: "Social", description: "Social metrics measure your communication between branch members.", score: wbScore.social)
            }
            
            NavigationLink{
                PhysicalAbstractView()
            } label: {
                ScoreComponentCard(iconName: "heart.text.square", name: "Physical", description: "Physical metrics measure your daily exercise and physical health indicator", score: wbScore.physical)
            }
            
            NavigationLink {
                FinancialAbstractView()
            } label: {
                ScoreComponentCard(iconName: "dollarsign.square", name: "Financial", description: "Financial metrics measures your credit score, income and living spends.", score: wbScore.financial)
            }
            
            NavigationLink {
                CommunityAbstractView()
            } label: {
                ScoreComponentCard(iconName: "globe.asia.australia", name: "Community", description: "Community metrics measure your living condition and environment quality.", score: wbScore.community)
            }
            
        }
        
    }
}

struct ScoreComponentsView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreComponentsView(wbScore: WBScore(dateCreated: Date(), career: 145/200, social: 133/200, physical: 178/200, financial: 108/200, community: 89/200))
    }
}
