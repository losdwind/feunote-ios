//
//  PhysicalWeeklySentimentChartView.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/8.
//

import SwiftUI


import Foundation
import SwiftUI
struct PhysicalWeeklySentimentChartView: View {
    var data1: [CGFloat] = (0...7).map { _ in CGFloat(arc4random_uniform(UInt32(10000))) / 10000 }
    var data2: [CGFloat] = (0...7).map { _ in CGFloat(arc4random_uniform(UInt32(10000))) / 10000 }

    var indicator: String {
        String("Emotional Damager")
    }



    @State var trim: CGFloat = 0

    @State var period = ChartPerid.Today
    let week = ["Mo", "Tu", "We", "Th","Fr","Sa", "Su"]
    var body: some View {

        VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
            //            ScoreTitleView(title: "Sleep", isShowingMenu: true, period: $period)

            VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge){
                Text("\(indicator) Hour")
                    .font(.ewTitle2)
                    .fontWeight(.bold)
                    .foregroundColor(.ewBlack)
                HStack{
                    Label {
                        Text("Happy").font(.ewFootnote)
                    } icon: {
                        Color("Happy").cornerRadius(.ewCornerRadiusRound).frame(width:10,height: 10)
                    }

                    Label {
                        Text("Anger").font(.ewFootnote)
                    } icon: {
                        Color("Anger").cornerRadius(.ewCornerRadiusRound).frame(width:10,height: 10)
                    }

                }
            }

            VStack(alignment: .leading, spacing: .ewPaddingVerticalSmall) {


                ZStack {
                    Chart(data: data1)
                        .chartStyle(
                            LineChartStyle(.quadCurve, lineColor: Color("Happy"), lineWidth: 4, trimTo: $trim)
                        )

                        .frame(height: 150)


                    Chart(data: data2)
                        .chartStyle(
                            LineChartStyle(.quadCurve, lineColor: Color("Anger"), lineWidth: 4, trimTo: $trim)
                        )

                        .frame(height: 150)

                }



                AxisLabels(.horizontal, data: 0...6, id: \.self) {
                    Text(week[$0])
                        .font(.ewFootnote)
                    //                            .frame(maxWidth: .infinity, alignment:  $0 != 6 ? .leading : .trailing)
                }
                .font(.footnote)
                .foregroundColor(Color.ewGray900)
                .frame(height: 20)
            }


        }
        .padding(.vertical, .ewPaddingVerticalDefault)
        .padding(.horizontal, .ewPaddingHorizontalDefault)
        .background(Color.ewGray50)
        .cornerRadius(.ewCornerRadiusDefault)

        .onAppear {
            trim = 0
            withAnimation(.easeInOut(duration: 1)) {
                trim = 1
            }
        }
    }

}

struct PhysicalWeeklySentimentChartView_Previews: PreviewProvider {

    static var previews: some View {
        PhysicalWeeklySentimentChartView()
            .padding()
    }
}
