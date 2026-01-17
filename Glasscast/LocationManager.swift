//
//  LocationManager.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import Foundation
internal import CoreLocation
internal import Combine

@MainActor
class LocationManager: NSObject, ObservableObject {
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var errorMessage: String?
    
    private let manager = CLLocationManager()
    
    override init() {
        authorizationStatus = manager.authorizationStatus
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        switch authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .denied, .restricted:
            errorMessage = "Location access denied. Please enable location services in Settings."
        @unknown default:
            errorMessage = "Unknown location authorization status"
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task { @MainActor in
            self.authorizationStatus = manager.authorizationStatus
            if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
                manager.requestLocation()
            } else if authorizationStatus == .denied || authorizationStatus == .restricted {
                self.errorMessage = "Location access denied. Please enable location services in Settings."
            }
        }
    }
    
    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { @MainActor in
            guard let location = locations.last else { return }
            self.location = location
            self.errorMessage = nil
        }
    }
    
    nonisolated func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Task { @MainActor in
            self.errorMessage = error.localizedDescription
        }
    }
}
