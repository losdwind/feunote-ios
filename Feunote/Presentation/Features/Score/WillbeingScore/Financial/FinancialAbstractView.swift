//
//  FinancialAbstractView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI

struct FinancialAbstractView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20){
        Text("Fico Score Summary Report")
                .font(.headline)
                        
        Text("Your FICO score is a credit score created by the Fair Isaac Corporation (FICO). Lenders use borrowers’ FICO scores along with other details on borrowers’ credit reports to assess credit risk and determine whether to extend credit. FICO scores take into account data in five areas to determine creditworthiness: payment history, current level of indebtedness, types of credit used, length of credit history, and new credit accounts.")
            
        Image("fico")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)


        Text("Zhima Credits")
                .font(.headline)
            Text("Zhima Credit, also known as Sesame Credit, is a private credit scoring and loyalty program system developed by Ant Group, an affiliate of the Chinese Alibaba Group. It uses data from Alibaba's services to compile its score. Customers receive a score based on a variety of factors based on social media interactions and purchases carried out on Alibaba Group websites or paid for using its affiliate Ant Financial's Alipay mobile wallet.")
        Image("zhima")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 270)
        Text("Credit History")
                .fontWeight(.semibold)

        //            LineGraph(data: [
        //                989,1200,750,790,650,950,1200,600,500,600,890,1203,1400,900,1250,1600,1200])
        //                .frame(height: 220)
        //                .padding()
            Spacer()
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
