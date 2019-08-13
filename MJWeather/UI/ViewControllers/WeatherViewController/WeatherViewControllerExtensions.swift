//
//  WeatherViewControllerExtensions.swift
//  MJWeather
//
//  Created by 구민준 on 04/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import UIKit

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyForecastTableViewCell") as! HourlyForecastTableViewCell
      cell.hourlyWeather = weather?.hourlyWeather
      cell.collectionView.reloadData()
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "DailyForecastTableViewCell") as! DailyForecastTableViewCell
      cell.dailyWeather = weather?.dailyWeather
      cell.collectionView.reloadData()
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 122
    } else if indexPath.row == 1 {
      guard let weather = weather else { return 0 }
      let count = weather.dailyWeather.dailyData.count
      return (CGFloat(54 * count + 4 * count))
    }
    return 0
  }
}
