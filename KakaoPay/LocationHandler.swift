//
//  LocationHandler.swift
//  KakaoPay
//
//  Created by 구민준 on 03/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation

class LocationHandler {
  func saveLocation(location newLocation: Location) {
    var locations = loadLocations()
    
    for location in locations {
      if location == newLocation { return }
    }
    
    locations.append(newLocation)
    updateLocations(locations: locations)
  }
  
  func isExistLocation(location newLocation: Location) -> Bool {
    let locations = loadLocations()
    
    for location in locations {
      if location == newLocation { return true }
    }
    return false
  }
  
  private func updateLocations(locations: [Location]) {
    UserDefaults.standard.encode(for: locations, using: "KPLocations")
    UserDefaults.standard.synchronize()
  }
  
  func loadLocations() -> [Location] {
    let locations = UserDefaults.standard.decode(for: [Location].self, using: "KPLocations")
    return locations ?? []
  }
  
  func removeLocation(location: Location) {
    var locations = loadLocations()
    
    for index in 0..<locations.count {
      if locations[index] == location {
        locations.remove(at: index)
        updateLocations(locations: locations)
        return
      }
    }
  }
}
