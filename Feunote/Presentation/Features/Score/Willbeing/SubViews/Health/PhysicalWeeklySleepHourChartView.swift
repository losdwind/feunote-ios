//
//  PhysicalDailyWalkingStepsChartView.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/6.
//

import Foundation
import SwiftUI
struct PhysicalWeeklySleepHourChartView: View {
    var data: [CGFloat] = (0...7).map { _ in CGFloat(arc4random_uniform(UInt32(5000))) / 10000 }
    var indicator: String {
        data.map { $0 * 1000 }.reduce(0, +).doubleToString(isPercentage: false)
    }
    var subTitle: String = "Average Sleep Hours"



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
                Text(subTitle)
                    .font(.ewHeadline)
                    .fontWeight(.bold)
                    .foregroundColor(.ewGray900)
            }

            VStack(alignment: .leading, spacing: .ewPaddingVerticalSmall) {


                Chart(data: data)
                    .chartStyle(
                        LineChartStyle(.quadCurve, lineColor: Color("Gradient3"), lineWidth: 4, trimTo: $trim)
                    )
                    .background(
                        GridPattern(horizontalLines: 0, verticalLines: 7)
                            .inset(by: 2)
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color("Gradient3").opacity(0.2),Color("Gradient3").opacity(0.2), .ewWhite]), startPoint: .bottom, endPoint: .top), style: .init(lineWidth: 2, lineCap: .round))
                    )
                    .frame(height: 150)



                AxisLabels(.horizontal, data: 0...6, id: \.self) {
                        Text(week[$0])
                            .font(.ewFootnote)
//                            .frame(maxWidth: .infinity, alignment:  $0 != 6 ? .leading : .trailing)
                }
                .font(.footnote)
                .foregroundColor(Color("Gradient3"))
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

struct PhysicalWeeklySleepHourChartView_Previews: PreviewProvider {

    static var previews: some View {
        PhysicalWeeklySleepHourChartView()
            .padding()
    }
}
