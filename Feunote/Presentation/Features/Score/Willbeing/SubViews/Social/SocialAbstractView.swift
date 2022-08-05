//
//  SocialAbstract.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI
import AmplifyMapLibreUI
import Amplify.
struct SocialAbstractView: View {
//    private var analytics:[Analytics] = analyticsData

    let locationManagement = LocationManagement()

    @StateObject private var mapState = AMLMapViewState(
        zoomLevel: 8,
        center: CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903)
    )

    var body: some View {
        ScrollView(.vertical, showsIndicators: false){


        VStack(alignment:.leading){
            LazyVGrid(columns: [GridItem(),GridItem()]) {
                SocialStatCardView(statResult: 4, statResultIncremental: 1, isPercentage: false, title: "New Friends", description: "No. of new persons added")
                SocialStatCardView(statResult: 15, statResultIncremental: -3, isPercentage: false, title: "Mentioned", description: "No. of persons mentioned in your notes")
                SocialStatCardView(statResult: 0.15, statResultIncremental: 0.05, isPercentage: true, title: "Description Quality", description: "Data completeness of persons ")
                SocialStatCardView(statResult: 0.16, statResultIncremental: 0.4, isPercentage: true, title: "Cold Breaking", description: "No. of communication restarted by you")

                SocialStatCardView(statResult: 143, statResultIncremental: 23, isPercentage: false, title: "Talkative", description: "No. of messages send in Squad")
            }

            AMLMapView()
                .featureImage { Color.ewGray50.frame(height: 150)}
                .featureTapped { mapView, pointFeature in
                    mapView.setCenter(
                        pointFeature.coordinate,
                        zoomLevel: mapView.zoomLevel + 2,
                        direction: mapView.camera.heading,
                        animated: true
                    )
                }
                .edgesIgnoringSafeArea(.all)

        }

        }
        .padding()

    }
}

struct SocialAbstract_Previews: PreviewProvider {
    static var previews: some View {
        SocialAbstractView()
    }
}
