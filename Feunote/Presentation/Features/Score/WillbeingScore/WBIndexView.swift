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
        
        VStack(alignment:.center, spacing: 20) {
            // segement: wellbeing index
            HStack(alignment: .center, spacing: 40){
                VStack(alignment:.center, spacing: 20){
                    Text("\(wbScore.career + wbScore.social + wbScore.physical + wbScore.financial + wbScore.community)")
                        .font(.custom("VeryLargeTitle", size: 70))
                        .foregroundColor(.accentColor)
                    Text("Wellbeing Index")
                        .font(.headline.bold())
                        .foregroundColor(Color.pink)
                        
                }
                
                
                VStack(alignment:.leading, spacing: 5){
                    HStack(alignment: .center){
                        Text("Career")
                            .font(.subheadline)
                        Spacer()
                        Text(String(wbScore.career))
                            .font(.body)
                    }

                    HStack(alignment: .center){
                        Text("Social")
                            .font(.subheadline)
                        Spacer()
                        Text(String(wbScore.social))
                            .font(.body)
                    }

                    HStack(alignment: .center){
                        Text("Physical")
                            .font(.subheadline)
                        Spacer()
                        Text(String(wbScore.physical))
                            .font(.body)
                    }

                    HStack(alignment: .center){
                        Text("Financial")
                            .font(.subheadline)
                        Spacer()
                        Text(String(wbScore.financial))
                            .font(.body)
                    }

                    HStack(alignment: .center){
                        Text("Community")
                            .font(.subheadline)
                        Spacer()
                        Text(String(wbScore.community))
                            .font(.body)
                    }
                }
                .frame(width: 150, height: 100)
                
                
                            
            }
            
            VStack(alignment:.leading, spacing: 10){
                
                Label {
                    Text("Evaluation Report")

                } icon: {
                    Image(systemName: "doc.text.image")
                }
                
                Text("We notice that your wellbeing index drops in the past week. One main reason is that your daily exercise didn't reach the average level of last month. Another main reason is one of your squad has been marked as not active during last month. It is very important for your personal wellbeing to maintain moderate exercise as well as social contact with your friends. ")
                    .lineLimit(5)
                    .font(.footnote)
                

            }
            

        }
        .padding()
        .background(Color.gray.opacity(0.2), in:RoundedRectangle(cornerRadius: 18))

    }
}

struct WBScoreView_Previews: PreviewProvider {
    static var previews: some View {
        WBScoreView(wbScore: WBScore(dateCreated: Date(), career: 145, social: 133, physical: 178, financial: 108, community: 89))
    }
}
