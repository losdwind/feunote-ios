//
//  FinancialAbstractView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI

struct FinancialAbstractView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){


            VStack(alignment: .center, spacing: .ewPaddingVerticalLarge){
            VStack(alignment: .center, spacing: .ewPaddingVerticalDefault){
                Text("Fico Score Summary Report")
                    .font(.ewHeadline)
                    .frame(maxWidth:.infinity, alignment: .leading)

                Text("Your FICO score is a credit score created by the Fair Isaac Corporation (FICO). Lenders use borrowers’ FICO scores along with other details on borrowers’ credit reports to assess credit risk and determine whether to extend credit. FICO scores take into account data in five areas to determine creditworthiness: payment history, current level of indebtedness, types of credit used, length of credit history, and new credit accounts.")
                    .font(.ewFootnote)
                EWButton(text: "Connect", image: nil, style: .primaryCapsule, action: {})
                    .frame(maxWidth:.infinity, alignment: .center)

            }

            VStack(alignment: .center, spacing: .ewPaddingVerticalDefault){
                Text("Zhima Credits")
                    .font(.ewHeadline)
                    .frame(maxWidth:.infinity, alignment: .leading)
                Text("Zhima Credit, also known as Sesame Credit, is a private credit scoring and loyalty program system developed by Ant Group, an affiliate of the Chinese Alibaba Group. It uses data from Alibaba's services to compile its score. Customers receive a score based on a variety of factors based on social media interactions and purchases carried out on Alibaba Group websites or paid for using its affiliate Ant Financial's Alipay mobile wallet.")
                    .font(.ewFootnote)

                EWButton(text: "Connect", image: nil, style: .primaryCapsule, action: {})
                    .frame(maxWidth:.infinity, alignment: .center)

            }

        Text("Credit History")
                    .font(.ewHeadline)
                .frame(maxWidth:.infinity, alignment: .leading)

                    LineGraph(data: [
                        989,1200,750,790,650,950,1200,600,500,600,890,1203,1400,900,1250,1600,1200])
                        .frame(height: 220)
                        .padding()
        }
        }
        .navigationTitle("Credit Score")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        
    }
    
}

struct FinancialAbstractView_Previews: PreviewProvider {
    static var previews: some View {
        FinancialAbstractView()
    }
}
