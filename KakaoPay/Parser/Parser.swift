//
//  Parser.swift
//  KakaoPay
//
//  Created by MinJun KOO on 01/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation

class Parser {
  func parseCurrentlyWeather(response: [String: Any]) -> CurrentlyWeather {
    // TODO: init CurrentlyWeather and return
    return CurrentlyWeather(weatherData: WeatherData())
  }

  func parseHourlyWeather(response: [String: Any]) -> HourlyWeather {
    // TODO: init HourlyWeather and return
    return HourlyWeather(iconName: "iconName", hourlyData: [WeatherData()])
  }

  func parseDailyWeather(response: [String: Any]) -> DailyWeather {
    // TODO: init DailyWeather and return
    return DailyWeather(iconName: "iconName", hourlyData: [WeatherData()])
  }
}
