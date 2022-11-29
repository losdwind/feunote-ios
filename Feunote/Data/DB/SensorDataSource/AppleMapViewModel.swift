//
//  MapViewModel.swift.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/25.
//

import MapKit
import SwiftUI
// import GeoFireUtils
class AppleMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region: MKCoordinateRegion = .init()

    @Published var currentLocation: CLLocation? {
        didSet {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: currentLocation?.coordinate.latitude ?? 89.417222, longitude: currentLocation?.coordinate.longitude ?? 43.075), span: MKCoordinateSpan())
        }
    }

    @Published var locations: [CLLocation] = []

    // SearchText...
    @Published var searchTxt = ""

    // Searched Places...
    @Published var places: [MKPlacemark] = .init()

    @Published var alertMessage: String?

    var locationManager: CLLocationManager?

    override init() {
        super.init()
        requestLocation()
    }

    func requestOneTimeLocation() {
        locationManager?.requestLocation()
    }

    func requestLocation() {
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager = CLLocationManager()
            self.locationManager?.delegate = self
        }else {
            alertMessage = "Location service was diabled, please go to enbale in the settings"
            self.locationManager?.requestAlwaysAuthorization()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Received authorization of user location, requesting for location")
            let deviceID = AppRepoManager.shared.dataStoreRepo.amplifyUser?.id
            print("deviceID: \(String(describing: deviceID))")
            locationManager?.startUpdatingLocation()
            locationManager?.allowsBackgroundLocationUpdates = true

        case .notDetermined, .restricted, .denied:
            locationManager?.requestAlwaysAuthorization()
        @unknown default:
            fatalError()
        }
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if Int(locations.first?.timestamp.timeIntervalSince1970 ?? 1) % 300 == 0 {
            DispatchQueue.main.async {
                self.currentLocation = locations.first
                print("Got locations: \(locations)")


                self.locations.append(self.currentLocation!)
            }


            saveLocation(locations: locations)
        }

    }


    func saveLocation(locations: [CLLocation]) {
        Task {
            do {
                try await SaveSourceUseCase().execute(sourceType: SourceType.gps, sourceData: "{\"lat\":\"\(locations.first?.coordinate.latitude.datatypeValue)\",\"lon\":\"\(locations.first?.coordinate.longitude.datatypeValue)\",\"speed\":\"\(locations.first?.speed.datatypeValue)\",\"time\":\"\(locations.first?.timestamp.timeIntervalSince1970.datatypeValue)\"}")
            } catch {
                print("save location error")
            }
        }
    }

    func getLocation(){
        Task {
            do {
                guard let creatorID = AppRepoManager.shared.dataStoreRepo.amplifyUser?.id else{return}
                let fetchedLocations = try await GetSourcesUseCase().execute(creatorID: creatorID)
//                self.locations = fetchedLocations.map({ location in
//                    location.sourceData
//                })
            } catch {
                print("save location error")
            }
        }
    }

    func reverseGeoCoding(location: CLLocation, completion: @escaping (_ placemark: CLPlacemark?) -> Void) {
        let geoCoder = CLGeocoder()

        geoCoder.reverseGeocodeLocation(location, preferredLocale: .current) { placemarks, _ in
            guard let placemark = placemarks?.first else {
                completion(nil)
                return
            }
            completion(placemark)
        }
    }

    func getOneTimeLocation(completion _: @escaping (_ placeName: String) -> Void) {
        switch locationManager?.authorizationStatus {
        case .none:
            locationManager?.requestLocation()
        case .some:
            break
        }
    }

    func searchQuery(completion: @escaping (_ placemarks: [MKPlacemark]) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt

        // Fetch...
        MKLocalSearch(request: request).start { response, _ in

            guard let result = response else { return }

            completion(result.mapItems.compactMap { $0.placemark })
        }
    }

    func geohash(location _: CLLocation) -> String {
//        return GFUtils.geoHash(forLocation: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
        return ""
    }

    // send location log to firebase
    func extractPlace(location: CLLocation, completion: @escaping (_ place: Place) -> Void) {
        // Add the hash and the lat/lng to the document. We will use the hash
        // for queries and the lat/lng for distance comparisons.
        reverseGeoCoding(location: location) {
            placemark in
            if let placemark = placemark {
                let hash = self.geohash(location: location)

                completion(Place(dateCreated: Date(), geohash: hash, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, locality: placemark.locality ?? "", administrationArea: placemark.administrativeArea ?? "", country: placemark.country ?? ""))
            }
        }
    }
}
