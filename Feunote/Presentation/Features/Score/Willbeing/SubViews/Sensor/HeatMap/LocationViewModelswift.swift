//
//  LocationManager.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/4.
//

// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import AWSLocationXCF
import AWSMobileClientXCF
import CoreLocation
import Foundation
import MapKit
import Amplify

class LocationViewModel: NSObject,
    ObservableObject,
    CLLocationManagerDelegate,
    AWSLocationTrackerDelegate
{


    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 89.417222, longitude: 43.075), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

    @Published var currentLocation: CLLocation?

    @Published var alertMessage: String?
    @Published var locations:[CLLocation] = []



    var locationManager = CLLocationManager()
    let locationTracker = AWSLocationTracker(trackerName: "explore.tracker",
                                             region: AWSRegionType.USWest2,
                                            credentialsProvider: AWSMobileClient.default())
    override init() {
        super.init()
        requestLocation()
    }

    func updateRegion(currentLocation: CLLocation) -> MKCoordinateRegion {
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

    }

    func requestLocation() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager = CLLocationManager()
                self.locationManager.delegate = self
            } else {
                self.alertMessage = "Location service was diabled, please go to enbale in the settings"
                self.locationManager.requestAlwaysAuthorization()
            }
        }

    }

    func requestOneTimeLocation() {
        locationManager.requestLocation()
    }

    func onTrackingEvent(event: TrackingListener) {
        switch event {
        case let .onDataPublished(trackingPublishedEvent):
            print("onDataPublished: \(trackingPublishedEvent)")
        case let .onDataPublicationError(error):
            switch error.errorType {
            case .invalidTrackerName, .trackerAlreadyStarted, .unauthorized:
                print("onDataPublicationError \(error)")
            case let .serviceError(serviceError):
                print("onDataPublicationError serviceError: \(serviceError)")
            }
        case .onStop:
            print("tracker stopped")
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Received authorization of user location, requesting for location")
                let deviceID = AppRepoManager.shared.authRepo.authUser?.userId
                print("deviceID: \(deviceID)")
            let result = locationTracker.startTracking(
                delegate: self,
                options: TrackerOptions(
                    customDeviceId:deviceID,
                    retrieveLocationFrequency: TimeInterval(30),
                    emitLocationFrequency: TimeInterval(120)
                ),
                listener: onTrackingEvent
            )
            switch result {
            case .success:
                print("Tracking started successfully")
            case let .failure(trackingError):
                switch trackingError.errorType {
                case .invalidTrackerName, .trackerAlreadyStarted, .unauthorized:
                    print("onFailedToStart \(trackingError)")
                case let .serviceError(serviceError):
                    print("onFailedToStart serviceError: \(serviceError)")
                }
            }
        default:
            print("Failed to authorize")
        }
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        print("Now is Tracking \(locationTracker.isTracking())")
        print("Got locations: \(locations.first)")
        self.currentLocation = locations.first
        if currentLocation != nil {
            self.region = self.updateRegion(currentLocation: currentLocation!)
        }
        self.locations = locations
        saveLocation(locations: locations)
        locationTracker.interceptLocationsRetrieved(locations)

    }

    func saveLocation(locations: [CLLocation]){
        Task {
            do {
                try await SaveSourceUseCase().execute(sourceType:SourceType.gps, sourceData: "{\"locations\": \(locations)")
            }catch {
                print("save location error")
            }
        }
    }


    // Error handling is required as part of developing using CLLocation
    func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        if let clErr = error as? CLError {
            switch clErr {
            case CLError.locationUnknown:
                print("location unknown")
            case CLError.denied:
                print("denied")
            default:
                print("other Core Location error")
            }
        } else {
            print("other error:", error.localizedDescription)
        }
    }

    /*
    func startTracking() async {
        do {
            try await Amplify.Geo.startTracking()
            Amplify.Geo.startTracking()
        } catch let error as Geo.Error {
            print("Failed to starting device tracking: \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }

    func stopTracking() {
        Amplify.Geo.stopTracking()
    }

    func updateLocation(_ location: Geo.Location) async {
        do {
            try await Amplify.Geo.updateLocation(location)
        } catch let error as Geo.Error {
            print("Failed to update location: \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }

    func deleteLocationHistory() async {
        do {
            try await Amplify.Geo.deleteLocationHistory()
        } catch let error as Geo.Error {
            print("Failed to delete location history: \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
     */
}
