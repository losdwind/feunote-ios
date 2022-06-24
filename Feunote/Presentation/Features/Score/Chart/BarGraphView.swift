//
//  BarChartView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

struct Analytics: Identifiable{
    
    var id = UUID().uuidString
    var num: CGFloat
    var weekDay: String
}

var analyticsData: [Analytics] = [

    Analytics(num: 50, weekDay: "Mon"),
    Analytics(num: 24, weekDay: "Tue"),
    Analytics(num: 35, weekDay: "Wed"),
    Analytics(num: 43, weekDay: "Thu"),
    Analytics(num: 69, weekDay: "Fri"),
    Analytics(num: 54, weekDay: "Sat"),
    Analytics(num: 92, weekDay: "Sun"),
]



import SwiftUI

struct BarGraph: View {
    var analytics: [Analytics]
    var body: some View {
        
        VStack(spacing: 20){
            // Graph View
            GraphView()
        }
        .padding(20)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.top)
    }
    
    @ViewBuilder
    func GraphView()->some View{
        
        GeometryReader{proxy in
            
            ZStack{
                
                VStack(spacing: 0){
                    
                    ForEach(getGraphLines(),id: \.self){line in
                        
                        HStack(spacing: 8){
                            
                            Text("\(Int(line))")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(height: 20)
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 1)
                        }
                        .frame(maxHeight: .infinity,alignment: .bottom)
                        // Removing the text size...
                        .offset(y: -15)
                    }
                }
                
                HStack{
                    ForEach(analytics){download in
                        
                        VStack(spacing: 0){
                            
                            VStack(spacing: 5){
                                Color("socialOrange")
                                    .cornerRadius(6)
                            }
                            .frame(width: 30)
                            .frame(height: getBarHeight(point: download.num, size: proxy.size))
                            
                            Text(download.weekDay)
                                .font(.caption)
                                .frame(height: 25,alignment: .bottom)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .padding(.leading,30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        // Fixed Height
        .frame(height: 190)
    }
    
    func getBarHeight(point: CGFloat,size: CGSize)->CGFloat{
        
        let max = getMax()
        
        // 25 Text Height
        // 5 Spacing..
        let height = (point / max) * (size.height - 37)
        
        return height
    }
    
    // getting Sample Graph Lines based on max Value...
    func getGraphLines()->[CGFloat]{
        
        let max = getMax()
        
        var lines: [CGFloat] = []
        
        lines.append(max)
        
        for index in 1...4{
            
            // dividing the max by 4 and iterating as index for graph lines...
            let progress = max / 4
            
            lines.append(max - (progress * CGFloat(index)))
        }
        
        return lines
    }
    
    // Getting Max....
    func getMax()->CGFloat{
        let max = analytics.max { first, scnd in
            return scnd.num > first.num
        }?.num ?? 0
        
        return max
    }
}

struct BarGraph_Previews: PreviewProvider {
    static var previews: some View {
        BarGraph(analytics: analyticsData)
    }
}
