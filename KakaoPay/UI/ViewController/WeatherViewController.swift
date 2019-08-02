//
//  WeatherViewController.swift
//  KakaoPay
//
//  Created by MinJun KOO on 02/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
  var latitude: Double?
  var longitude: Double?
  var region: String = ""
  private var weather: Weather?
  
  @IBOutlet weak var regionLabel: UILabel!
  @IBOutlet weak var currentStateLabel: UILabel!
  @IBOutlet weak var weatherImageView: UIImageView!
  @IBOutlet weak var currentTemperatureLabel: UILabel!
  @IBOutlet weak var minMaxTemperatureLabel: UILabel!
  
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var precipProbabilityLabel: UILabel!
  @IBOutlet weak var apparentTemperatureLabel: UILabel!
  @IBOutlet weak var pressureLabel: UILabel!
  @IBOutlet weak var windSpeedLabel: UILabel!
  @IBOutlet weak var windBearingLabel: UILabel!
  @IBOutlet weak var uvIndexLabel: UILabel!
  @IBOutlet weak var visibilityLabel: UILabel!
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let latitude = latitude, let longitude = longitude {
      WeatherRequest().loadWeather(latitude: latitude, longitude: longitude, onSuccess: { (weather) in
        // TODO
        DispatchQueue.main.async {
          if let _ = weather.dailyWeather.dailyData.first {
            let temperature = weather.dailyWeather.dailyData.removeFirst()
            self.minMaxTemperatureLabel.text = "\(temperature.temperatureMax ?? 0) / \(temperature.temperatureMin ?? 0)"
          }
          self.weather = weather
          self.setCurrentWeatherData(weather: weather.currentlyWeather)
          self.tableView.reloadData()
        }
      }, onFailure: { (error) in
        if let error = error { print(error.localizedDescription) }
      })
    }
  }
  
  private func setCurrentWeatherData(weather: CurrentlyWeather) {
    let current = weather.data
    
    regionLabel.text = region
    currentStateLabel.text = current.iconName // TODO: iconName에 맞는 이름으로 변환
    if let icon = current.iconName { weatherImageView.image = UIImage(named: icon) }
    currentTemperatureLabel.text = "\(current.temperature ?? 0)"
    
    //    minMaxTemperatureLabel.text =  // TODO: 이건 daily의 첫번쨰에서 해결
    humidityLabel.text = "\(current.humidity ?? 0)"
    precipProbabilityLabel.text = "\(current.precipProbability ?? 0)"
    apparentTemperatureLabel.text = "\(current.apparentTemperature ?? 0)"
    pressureLabel.text = "\(current.pressure ?? 0)"
    windSpeedLabel.text = "\(current.windSpeed ?? 0)"
    windBearingLabel.text = "\(current.windBearing ?? 0)" // TODO: 숫자에 따라 방향으로 바꾸기
    uvIndexLabel.text = "\(current.uvIndex ?? 0)"
    visibilityLabel.text = "\(current.visibility ?? 0)"
  }
}

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
