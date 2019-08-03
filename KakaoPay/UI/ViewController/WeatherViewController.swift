//
//  WeatherViewController.swift
//  KakaoPay
//
//  Created by MinJun KOO on 02/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import UIKit

protocol WeatherViewControllerDelegate {
  func removeFromPageViewController(vc viewController: UIViewController)
}

class WeatherViewController: UIViewController {
  var latitude: Double?
  var longitude: Double?
  var region: String = ""
  private var weather: Weather?
  private var refreshControl = UIRefreshControl()
  
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
  @IBOutlet weak var deleteImageView: UIImageView!
  
  @IBOutlet weak var lastUpdateTimeLabel: UILabel!
  
  var delegate: WeatherViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadWeather()
    tableView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(refreshWeather), for: .valueChanged)
    
    let deleteImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(removeViewController))
    deleteImageView.addGestureRecognizer(deleteImageTapGesture)
    deleteImageView.isUserInteractionEnabled = true
  }
  
  @objc private func refreshWeather() {
    guard let weather = weather else {
      refreshControl.endRefreshing()
      return
    }
    
    guard let time = weather.currentlyWeather.data.time else {
      refreshControl.endRefreshing()
      return
    }
    
    if TimeHandler().convertTimeStampToDateFormatter(timeStamp: time) != TimeHandler().convertTimeStampToDateFormatter(timeStamp: Int(Date().timeIntervalSince1970)) {
      loadWeather {
        self.refreshControl.endRefreshing()
      }
    } else {
      refreshControl.endRefreshing()
    }
  }
  
  private func loadWeather(onSuccess: (() -> ())? = nil) {
    if let latitude = latitude, let longitude = longitude {
      WeatherRequest().loadWeather(latitude: latitude, longitude: longitude, onSuccess: { (weather) in
        DispatchQueue.main.async {
          if let _ = weather.dailyWeather.dailyData.first {
            let temperature = weather.dailyWeather.dailyData.removeFirst()
            self.minMaxTemperatureLabel.text = "\(temperature.temperatureMax ?? 0)°C / \(temperature.temperatureMin ?? 0)°C"
          }
          
          weather.hourlyWeather.hourlyData.remove(at: 0)
          
          self.weather = weather
          self.setCurrentWeatherData(weather: weather.currentlyWeather)
          self.tableView.reloadData()
          if let onSuccess = onSuccess {
            onSuccess()
          }
        }
      }, onFailure: { (error) in
        if let error = error { print(error.localizedDescription) }
      })
    }
  }
  
  private func setCurrentWeatherData(weather: CurrentlyWeather) {
    let current = weather.data
    
    regionLabel.text = region
    currentStateLabel.text = WeatherStateHandler().changeToString(icon: current.iconName ?? "")
    if let icon = current.iconName { weatherImageView.image = UIImage(named: icon) }
    currentTemperatureLabel.text = "\(current.temperature ?? 0)°C"
    humidityLabel.text = "\(current.humidity ?? 0)%"
    precipProbabilityLabel.text = "\(current.precipProbability ?? 0)%"
    apparentTemperatureLabel.text = "\(current.apparentTemperature ?? 0)°C"
    pressureLabel.text = "\(current.pressure ?? 0)hPa"
    windSpeedLabel.text = "\(current.windSpeed ?? 0)m/s"
    windBearingLabel.text = WeatherStateHandler().changeWindBearingToDirection(windBearing: current.windBearing ?? 0)
    uvIndexLabel.text = "\(current.uvIndex ?? 0)"
    visibilityLabel.text = "\(current.visibility ?? 0)Km"
    lastUpdateTimeLabel.text = "날씨 데이터 업데이트 시간 : " + TimeHandler().convertTimeStampToDateFormatter(timeStamp: current.time ?? 0)
  }
  
  @objc private func removeViewController() {
    delegate?.removeFromPageViewController(vc: self)
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
