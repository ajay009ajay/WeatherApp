//
//  LocationManagerHelper.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import CoreLocation
import Combine

class LocationManagerHelper: NSObject, CLLocationManagerDelegate {
    static let shared: LocationManagerHelper = LocationManagerHelper()

    @Published var userLocation: CLLocation?
    private let locationManager = CLLocationManager()
    private override init() {}

    func monitorLocation() {
        locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("Location access not determined yet.")
        case .restricted, .denied:
            print("Location access denied or restricted.")
        case .authorizedWhenInUse:
            print("Location access granted when in use.")
        case .authorizedAlways:
            print("Location access granted always.")
        @unknown default:
            // Handle future cases or unknown states
            print("Unknown authorization status.")
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if let newLocation = locations.first {
            self.userLocation = newLocation
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error.localizedDescription)")
    }
}
