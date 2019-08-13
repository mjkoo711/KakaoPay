//
//  Parser.swift
//  MJWeather
//
//  Created by MinJun KOO on 01/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation

class Parser {
  func parseCurrentlyWeather(response: [String: Any]) -> CurrentlyWeather {
    let data = parseWeatherData(response: response)
    return CurrentlyWeather(weatherData: data)
  }

  func parseHourlyWeather(response: [String: Any]) -> HourlyWeather? {
    let icon = response["icon"] as? String
    guard let datas = response["data"] as? [[String: Any]] else { return nil }
    var weatherDatas: [WeatherData] = []

    for data in datas {
      weatherDatas.append(parseWeatherData(response: data))
    }
    return HourlyWeather(iconName: icon, hourlyData: weatherDatas)
  }

  func parseDailyWeather(response: [String: Any]) -> DailyWeather? {
    let icon = response["icon"] as? String

    guard let datas = response["data"] as? [[String: Any]] else { return nil }
    var weatherDatas: [WeatherData] = []

    for data in datas {
      weatherDatas.append(parseWeatherData(response: data))
    }
    return DailyWeather(iconName: icon, dailyData: weatherDatas)
  }

  private func parseWeatherData(response: [String: Any]) -> WeatherData {
    let time = response["time"] as? Int
    let icon = response["icon"] as? String
    let precipProbability = response["precipProbability"] as? Double
    let temperature = response["temperature"] as? Double
    let apparentTemperature = response["apparentTemperature"] as? Double
    let humidity = response["humidity"] as? Double
    let pressure = response["pressure"] as? Double
    let windSpeed = response["windSpeed"] as? Double
    let windBearing = response["windBearing"] as? Int
    let uvIndex = response["uvIndex"] as? Int
    let visibility = response["visibility"] as? Double

    let sunriseTime = response["sunriseTime"] as? Int
    let sunsetTime = response["sunsetTime"] as? Int
    let precipType = response["precipType"] as? String
    let temperatureMin = response["temperatureMin"] as? Double
    let temperatureMax = response["temperatureMax"] as? Double

    let data = WeatherData(time: time, iconName: icon, precipProbability: precipProbability, temperature: temperature, apparentTemperature: apparentTemperature, humidity: humidity, pressure: pressure, windSpeed: windSpeed, windBearing: windBearing, uvIndex: uvIndex, visibility: visibility, sunriseTime: sunriseTime, sunsetTime: sunsetTime, precipType: precipType, temperatureMin: temperatureMin, temperatureMax: temperatureMax)

    return data
  }
}
