//
//  Weather.swift
//  KakaoPay
//
//  Created by MinJun KOO on 01/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation

class Weather {
  let latitude: Double
  let longitude: Double
  let currentlyWeather: CurrentlyWeather
  let hourlyWeather: HourlyWeather
  let dailyWeather: DailyWeather

  init(latitude: Double, longitude: Double, currentlyWeather: CurrentlyWeather, hourlyWeather: HourlyWeather, dailyWeather: DailyWeather) {
    self.latitude = latitude
    self.longitude = longitude
    self.currentlyWeather = currentlyWeather
    self.hourlyWeather = hourlyWeather
    self.dailyWeather = dailyWeather
  }
}
