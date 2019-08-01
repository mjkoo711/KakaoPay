//
//  DailyWeather.swift
//  KakaoPay
//
//  Created by MinJun KOO on 01/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation

class DailyWeather {
  let iconName: String
  let hourlyData: [WeatherData]

  init(iconName: String, hourlyData: [WeatherData]) {
    self.iconName = iconName
    self.hourlyData = hourlyData
  }
}
