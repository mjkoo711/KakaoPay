//
//  WeatherData.swift
//  KakaoPay
//
//  Created by MinJun KOO on 01/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation

class WeatherData {
  let time: Int?
  let iconName: String?
  let precipProbability: Double? // 강수확률
  let temperature: Double?
  let apparentTemperature: Double?
  let humidity: Double?
  let pressure: Double?
  let windSpeed: Double?
  let windBearing: Int? // 바람 방향
  let uvIndex: Int?
  let visibility: Double? // 가시거리

  let sunriseTime: Int? // only daily
  let sunsetTime: Int? // only daily
  let precipType: String? // only daily
  let temperatureMin: Double? // only daily
  let temperatureMax: Double? // only daily

  init(time: Int? = nil, iconName: String? = nil, precipProbability: Double? = nil, temperature: Double? = nil, apparentTemperature: Double? = nil, humidity: Double? = nil, pressure: Double? = nil, windSpeed: Double? = nil, windBearing: Int? = nil, uvIndex: Int? = nil, visibility: Double? = nil, sunriseTime: Int? = nil, sunsetTime: Int? = nil, precipType: String? = nil, temperatureMin: Double? = nil, temperatureMax: Double? = nil) {
    self.time = time
    self.iconName = iconName
    self.precipProbability = precipProbability
    self.temperature = temperature
    self.apparentTemperature = apparentTemperature
    self.humidity = humidity
    self.pressure = pressure
    self.windSpeed = windSpeed
    self.windBearing = windBearing
    self.uvIndex = uvIndex
    self.visibility = visibility
    self.sunriseTime = sunriseTime
    self.sunsetTime = sunsetTime
    self.precipType = precipType
    self.temperatureMin = temperatureMin
    self.temperatureMax = temperatureMax
  }
}
