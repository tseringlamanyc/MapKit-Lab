//
//  CorelocationSession.swift
//  MapKit-Lab
//
//  Created by Tsering Lama on 2/24/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation
import CoreLocation

class CoreLocationSession: NSObject {
    public var locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        
        // request user location
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        // change info.plist
        // NSLocationAlwaysAndWhenInUseUsageDescription , NSLocationWhenInUseUsageDescription
        
        // getting updates for user location
        // locationManager.startUpdatingLocation()
        
        startSigLocationChange()
        //       monitorRegion()
    }
    
    private func startSigLocationChange() {
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            return
        }
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    public func coordinateToPlacemark(coordinate: CLLocationCoordinate2D) {
        // use CLGeoCoder() to convert coordinate to placemark
        
        // create a CLLocation
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("reverse geocode location error: \(error)")
            }
            if let firstPlacemark = placemarks?.first {
                print("placemark: \(firstPlacemark)")
            }
        }
    }
    
    public func placemarkToCoordinate(address: String, completion: @escaping(Result<CLLocationCoordinate2D, Error>) -> ()) {
        // converting address to coordinates
        CLGeocoder().geocodeAddressString(address) { (placemark, error) in
            if let error = error {
                print("geoaddresserror: \(error)")
                completion(.failure(error))
            }
            if let firstPlacemark = placemark?.first ,
                let location = firstPlacemark.location {
                print("coordinates: \(location.coordinate)")
                completion(.success(location.coordinate))
            }
        }
    }
    
    // setting up region : CLRegion (center coordinate and a radius in meters)
//    public func monitorRegion() {
//        let location = Location.getLocations()[2]
//        let identifier = "Monitoring Region"
//        let region = CLCircularRegion(center: location.coordinate, radius: 500, identifier: identifier)
//        region.notifyOnEntry = true
//        region.notifyOnExit = false
//
//        locationManager.startMonitoring(for: region)
//    }
}


extension CoreLocationSession: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocation: \(locations)")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            print("always")
        case .authorizedWhenInUse:
            print("inUse")
        case .denied:
            print("denied")
        case .notDetermined:
            print("notDetermined")
        case .restricted:
            print("restricted")
        default:
            print("default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didEnterRegion")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("didExitRegion")
    }
}

