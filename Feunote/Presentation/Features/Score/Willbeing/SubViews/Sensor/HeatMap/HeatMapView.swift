//
//  HeatMap.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/25.
//

import SwiftUI
import MapKit

struct HeatMapView: View {
    @StateObject var mapvm:MapViewModel = MapViewModel()
    @State var trackMode = MapUserTrackingMode.follow
    
    var body: some View {
        
        Map(coordinateRegion: $mapvm.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackMode)
            .ignoresSafeArea()
            .tint(.pink)
            .onAppear {
                mapvm.checkIfLocationServiceEnabled()
            }
            .navigationTitle("Daily Traces")
        
    }
}

struct HeatMapView_Previews: PreviewProvider {
    static var previews: some View {
        HeatMapView()
    }
}
