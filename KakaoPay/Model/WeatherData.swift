//
//  WeatherData.swift
//  KakaoPay
//
//  Created by MinJun KOO on 01/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation

class WeatherData {
  let time: String?
  let iconName: String?
  let precipProbability: Double? // 강수확률
  let temperature: Float?
  let apparentTemperature: Float?
  let humidity: Float?
  let pressure: Float?
  let windSpeed: Float?
  let windBearing: Int? // 바람 방향
  let uvIndex: Int?
  let visibility: Float? // 가시거리 

  let sunriseTime: UInt? // only daily
  let sunsetTime: UInt? // only daily
  let precipType: String? // only daily
  let temperatureMin: Float? // only daily
  let temperatureMax: Float? // only daily

  init(time: String? = nil, iconName: String? = nil, precipProbability: Double? = nil, temperature: Float? = nil, apparentTemperature: Float? = nil, humidity: Float? = nil, pressure: Float? = nil, windSpeed: Float? = nil, windBearing: Int? = nil, uvIndex: Int? = nil, visibility: Float? = nil, sunriseTime: UInt? = nil, sunsetTime: UInt? = nil, precipType: String? = nil, temperatureMin: Float? = nil, temperatureMax: Float? = nil) {
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
