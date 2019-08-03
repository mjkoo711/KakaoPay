//
//  KPLocationManager.swift
//  KakaoPay
//
//  Created by MinJun KOO on 01/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation
import CoreLocation

class KPLocationManager: NSObject {
  let locationManager: CLLocationManager
  static let sharedManager = KPLocationManager()

  override private init() {
    locationManager = CLLocationManager()
  }

  private func setupLocationManager() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }

  func checkLocationServices() {
    if CLLocationManager.locationServicesEnabled() {
      setupLocationManager()
      checkLocationAuthorization()
    } else {

    }
  }

  private func checkLocationAuthorization() {
    switch CLLocationManager.authorizationStatus() {
    case .authorizedWhenInUse:
      break
    case .denied:
      break
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
      break
    case .restricted:
      break
    case .authorizedAlways:
      break
    }
  }
}

extension KPLocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    // TODO
  }

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    // TODO
  }
}

