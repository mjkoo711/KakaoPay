//
//  KPLocationManager.swift
//  MJWeather
//
//  Created by MinJun KOO on 01/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation
import CoreLocation

protocol KPLocationManagerDelegate {
  func showCurrentLocationWeather()
  func isUpdateRequired(location: CLLocation) -> Bool
  func dismissCurrentLocationWeatherViewController()
}

class KPLocationManager: NSObject {
  let locationManager: CLLocationManager
  static let shared = KPLocationManager()
  var delegate: KPLocationManagerDelegate?
  
  override private init() {
    locationManager = CLLocationManager()
  }
  
  private func setUp() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }
  
  func checkLocationServices(onSuccess: @escaping (Location) -> (), onFailure: @escaping () -> ()) {
    if CLLocationManager.locationServicesEnabled() {
      setUp()
      checkLocationAuthorization(onSuccess: onSuccess, onFailure: onFailure)
    } else {
      
    }
  }
  
  private func getLocation(onSuccess: @escaping (Location) -> (), onFailure: @escaping () -> ()) {
    locationManager.requestLocation()
    guard let location = locationManager.location else {
      onFailure()
      return
    }
    let latitude = ((location.coordinate.latitude * 100).rounded()) / 100
    let longitude = ((location.coordinate.longitude * 100).rounded()) / 100
    
    CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
      guard let placemarks = placemarks else { return }
      if placemarks.count == 0 { return }
      let placemark = placemarks[0]
      let firstSpace = placemark.administrativeArea ?? placemark.subAdministrativeArea ?? ""
      let secondSpace = placemark.locality ?? ""
      let thirdSpace = placemark.subLocality ?? ""
      let region = (firstSpace.count != 0 ? firstSpace + " " : "") + (secondSpace.count != 0 ? secondSpace + " " : "") + (thirdSpace.count != 0 ? thirdSpace : "")
    
      WeatherRequest().loadWeather(latitude: latitude, longitude: longitude, onSuccess: { (weather) in
        onSuccess(Location(latitude: latitude, longitude: longitude, region: region))
      }, onFailure: { (error) in
        if let error = error { print(error.localizedDescription) }
        onFailure()
      })
    }
  }
  
  private func checkLocationAuthorization(onSuccess: @escaping (Location) -> (), onFailure: @escaping () -> ()) {
    switch CLLocationManager.authorizationStatus() {
    case .authorizedWhenInUse:
      getLocation(onSuccess: onSuccess, onFailure: onFailure)
      break
    case .denied:
      onFailure()
      break
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
      break
    case .restricted:
      onFailure()
      break
    case .authorizedAlways:
      getLocation(onSuccess: onSuccess, onFailure: onFailure)
      break
    @unknown default:
      onFailure()
    }
  }
}

extension KPLocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let delegate = delegate else { return }
    if delegate.isUpdateRequired(location: locations[0]) {
      delegate.showCurrentLocationWeather()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways || status == .authorizedWhenInUse {
      delegate?.showCurrentLocationWeather()
    } else {
      delegate?.dismissCurrentLocationWeatherViewController()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error.localizedDescription)
  }
}

