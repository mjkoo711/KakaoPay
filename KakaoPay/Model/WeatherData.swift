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
  let precipProbability: Int? // 강수확률
  let temperature: Int?
  let apparentTemperature: Int?
  let humidity: Int?
  let pressure: Int?
  let windSpeed: Int?
  let windBearing: Int? // 바람 방향
  let uvIndex: Int?
  let visibility: Double? // 가시거리

  let sunriseTime: Int? // only daily
  let sunsetTime: Int? // only daily
  let precipType: String? // only daily
  let temperatureMin: Int? // only daily
  let temperatureMax: Int? // only daily

  init(time: Int? = nil, iconName: String? = nil, precipProbability: Double? = nil, temperature: Double? = nil, apparentTemperature: Double? = nil, humidity: Double? = nil, pressure: Double? = nil, windSpeed: Double? = nil, windBearing: Int? = nil, uvIndex: Int? = nil, visibility: Double? = nil, sunriseTime: Int? = nil, sunsetTime: Int? = nil, precipType: String? = nil, temperatureMin: Double? = nil, temperatureMax: Double? = nil) {
    self.time = time
    self.iconName = iconName
    self.precipProbability = Int(((precipProbability ?? 0) * 100).rounded())
    self.temperature = Int(temperature?.rounded() ?? 0)
    self.apparentTemperature = Int(apparentTemperature?.rounded() ?? 0)
    self.humidity = Int(((humidity ?? 0) * 100).rounded())
    self.pressure = Int(pressure?.rounded() ?? 0)
    self.windSpeed = Int(windSpeed?.rounded() ?? 0)
    self.windBearing = windBearing
    self.uvIndex = uvIndex
    self.visibility = ((visibility ?? 0) * 10).rounded() / 10
    self.sunriseTime = sunriseTime
    self.sunsetTime = sunsetTime
    self.precipType = precipType
    self.temperatureMin = Int(temperatureMin?.rounded() ?? 0)
    self.temperatureMax = Int(temperatureMax?.rounded() ?? 0)
  }
}
