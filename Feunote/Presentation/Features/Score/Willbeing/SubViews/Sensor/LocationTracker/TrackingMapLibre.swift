//
//  TrackingMapLibre.swift
//  Feunote
//
//  Created by Losd wind on 2022/9/9.
//

// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0
//import AWSCore
//import Mapbox
//import SwiftUI
//
//
//import SwiftUI
//
//struct TrackMapLibre: View {
//    @State private var attribution = ""
//
//    var body: some View {
//        MapView(attribution: $attribution)
//            .centerCoordinate(.init(latitude: 49.2819, longitude: -123.1187))
//            .zoomLevel(12)
//            .edgesIgnoringSafeArea(.all)
//            .overlay(
//                TextField("", text: $attribution)
//                    .disabled(true)
//                    .font(.system(size: 12, weight: .light, design: .default))
//                    .foregroundColor(.black)
//                    .background(Color.init(Color.RGBColorSpace.sRGB, white: 0.5, opacity: 0.5))
//                    .cornerRadius(1),
//                alignment: .bottomTrailing)
//    }
//}
//
//struct TrackMapLibre_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackMapLibre()
//    }
//}
//
//
//
//struct MapView: UIViewRepresentable {
//    @Binding var attribution: String
//
//    private let mapView: MGLMapView
//    private let signingDelegate: MGLOfflineStorageDelegate
//
//    init(attribution: Binding<String>) {
//        let regionName = Bundle.main.object(forInfoDictionaryKey: "AWSRegion") as! String
//        let identityPoolId = Bundle.main.object(forInfoDictionaryKey: "IdentityPoolId") as! String
//        let mapName = Bundle.main.object(forInfoDictionaryKey: "MapName") as! String
//
//        let region = (regionName as NSString).aws_regionTypeValue()
//
//        // MGLOfflineStorage doesn't take ownership, so this needs to be a member here
//        signingDelegate = AWSSignatureV4Delegate(region: region, identityPoolId: identityPoolId)
//
//        // register a delegate that will handle SigV4 signing
//        MGLOfflineStorage.shared.delegate = signingDelegate
//
//        mapView = MGLMapView(
//            frame: .zero,
//            styleURL: URL(string: "https://maps.geo.\(regionName).amazonaws.com/maps/v0/maps/\(mapName)/style-descriptor"))
//
//        _attribution = attribution
//    }
//
//    // MARK: - UIViewRepresentable protocol
//    func makeCoordinator() -> Coordinator {
//        Coordinator($attribution)
//    }
//
//    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MGLMapView {
//        mapView.delegate = context.coordinator
//
//        mapView.logoView.isHidden = true
//        mapView.attributionButton.isHidden = true
//        return mapView
//    }
//
//    func updateUIView(_ uiView: MGLMapView, context: UIViewRepresentableContext<MapView>) {
//    }
//
//    // MARK: - MGLMapViewDelegate
//    class Coordinator: NSObject, MGLMapViewDelegate {
//        var attribution: Binding<String>
//
//        init(_ attribution: Binding<String>) {
//            self.attribution = attribution
//        }
//
//        func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
//            let source = style.sources.first as? MGLVectorTileSource
//            let attribution = source?.attributionInfos.first
//            self.attribution.wrappedValue = attribution?.title.string ?? ""
//        }
//    }
//
//    // MARK: - MGLMapView proxy
//    func centerCoordinate(_ centerCoordinate: CLLocationCoordinate2D) -> MapView {
//        mapView.centerCoordinate = centerCoordinate
//        return self
//    }
//
//    func zoomLevel(_ zoomLevel: Double) -> MapView {
//        mapView.zoomLevel = zoomLevel
//        return self
//    }
//}
