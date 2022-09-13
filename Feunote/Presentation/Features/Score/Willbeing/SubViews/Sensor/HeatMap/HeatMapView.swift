//
//  HeatMap.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/25.
//

import MapKit
import SwiftUI

struct HeatMapView: View {
    @StateObject var mapvm: LocationViewModel = LocationViewModel()
    @State var trackMode = MapUserTrackingMode.follow

    var body: some View {
        Map(coordinateRegion: $mapvm.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackMode)
            .ignoresSafeArea()
            .tint(.pink)

            .navigationTitle("Daily Traces")
    }
}

struct HeatMapView_Previews: PreviewProvider {
    static var previews: some View {
        HeatMapView()
    }
}
