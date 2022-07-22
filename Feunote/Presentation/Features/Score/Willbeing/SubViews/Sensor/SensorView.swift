//
//  SensorView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/22.
//

import SwiftUI

struct SensorView: View {
    var body: some View {
        VStack(alignment:.leading, spacing: .ewPaddingVerticalDefault) {
            Label {
                Text("Sensors")
                    .font(.ewHeadline)
                
            } icon: {
                Image(systemName: "sensor.tag.radiowaves.forward")
            }
            
            NavigationLink {
                HeatMapView()
            } label: {
                Image("demo-map-screenshot")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height:200)
            }
            
        }
        
    }
}

struct SensorView_Previews: PreviewProvider {
    static var previews: some View {
        SensorView()
    }
}
