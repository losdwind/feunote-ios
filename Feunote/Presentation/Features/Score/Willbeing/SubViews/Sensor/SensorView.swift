//
//  SensorView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/22.
//

import AmplifyMapLibreUI
import CoreLocation
import SwiftUI

struct SensorView: View {
    @StateObject private var mapState = AMLMapViewState(
        zoomLevel: 8,
        center: CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903)
    )

    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
            Label {
                Text("Sensors")
                    .font(.ewHeadline)

            } icon: {
                Image(systemName: "sensor.tag.radiowaves.forward")
            }

//            NavigationLink {
//                HeatMapView()
//            } label: {
//                Image("demo-map-screenshot")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(height:200)
//            }

            // aws location

//            AMLMapView()
//                .featureImage { UIImage(named: "demo-person-1")!}
//                .featureTapped { mapView, pointFeature in
//                    mapView.setCenter(
//                        pointFeature.coordinate,
//                        zoomLevel: mapView.zoomLevel + 2,
//                        direction: mapView.camera.heading,
//                        animated: true
//                    )
//                }
//                .frame(height: 150)
        }
    }
}

struct SensorView_Previews: PreviewProvider {
    static var previews: some View {
        SensorView()
    }
}
