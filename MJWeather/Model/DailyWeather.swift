//
//  DailyWeather.swift
//  MJWeather
//
//  Created by MinJun KOO on 01/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation

class DailyWeather {
  let iconName: String?
  var dailyData: [WeatherData]

  init(iconName: String?, dailyData: [WeatherData]) {
    self.iconName = iconName
    self.dailyData = dailyData
  }
}
