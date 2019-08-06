//
//  WeatherRequest.swift
//  KakaoPay
//
//  Created by MinJun KOO on 01/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation

class WeatherRequest {
  func loadWeather(latitude: Double, longitude: Double, onSuccess: @escaping (Weather) -> (), onFailure: @escaping (Error?) -> ()) {
    let request = Request(baseURLString: Const.baseURL)
    let path = "/forecast/" + Key.DARK_SKY_API_KEY + "/" + "\(latitude),\(longitude)"
    let params = ["units": "si"]
    
    request.get(path: path, parameters: params) { (response, error) in
      guard let response = response else { return }
      let parser = Parser()

      guard let currentlyWeatherResponse = response["currently"] as? [String: Any] else { return }
      guard let hourlyWeatherResponse = response["hourly"] as? [String: Any] else { return }
      guard let dailyWeatherResponse = response["daily"] as? [String: Any] else { return }

      let currentlyWeather = parser.parseCurrentlyWeather(response: currentlyWeatherResponse)
      guard let hourlyWeather = parser.parseHourlyWeather(response: hourlyWeatherResponse) else { return }
      guard let dailyWeather = parser.parseDailyWeather(response: dailyWeatherResponse) else { return }

      let weather = Weather(latitude: latitude, longitude: longitude, currentlyWeather: currentlyWeather, hourlyWeather: hourlyWeather, dailyWeather: dailyWeather)

      onSuccess(weather)
    }
  }
}
