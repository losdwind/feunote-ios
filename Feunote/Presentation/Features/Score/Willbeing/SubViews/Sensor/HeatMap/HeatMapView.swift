//
//  HeatMap.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/25.
//

import MapKit
import SwiftUI

extension CLLocation:Identifiable {
}
struct HeatMapView: View {
    @EnvironmentObject var mapvm:AppleMapViewModel
    @State var trackMode = MapUserTrackingMode.follow

    var body: some View {
        Map(coordinateRegion: $mapvm.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackMode, annotationItems: mapvm.locations ,annotationContent: { location in
            MapPin(coordinate: location.coordinate, tint: .pink)
        })
            .ignoresSafeArea()
            .navigationTitle("Daily Traces")
    }
}

struct HeatMapView_Previews: PreviewProvider {
    static var previews: some View {
        HeatMapView()
    }
}
