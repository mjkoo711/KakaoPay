//
//  Location.swift
//  KakaoPay
//
//  Created by MinJun KOO on 01/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation

class Location: Codable {
  let latitude: Double
  let longitude: Double
  let region: String

  init(latitude: Double, longitude: Double, region: String) {
    self.latitude = latitude
    self.longitude = longitude
    self.region = region
  }
}

extension Location: Equatable {
  static func == (lhs: Location, rhs: Location) -> Bool {
    if lhs.latitude == rhs.latitude, lhs.longitude == rhs.longitude {
      return true
    } else {
      return false
    }
  }
}
