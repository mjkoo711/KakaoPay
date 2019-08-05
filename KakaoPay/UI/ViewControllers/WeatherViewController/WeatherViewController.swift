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
  var isCurrentLocation = false
  
  internal var weather: Weather?
  internal var refreshControl: UIRefreshControl?
  
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
  @IBOutlet weak var currentLocationLabel: UILabel!
  
  var delegate: WeatherViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    if isCurrentLocation {
      currentLocationLabel.text = "현재 위치"
      deleteImageView.image = nil
    } else {
      let deleteImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(removeViewController))
      deleteImageView.addGestureRecognizer(deleteImageTapGesture)
      deleteImageView.isUserInteractionEnabled = true
    }
    refreshControl = UIRefreshControl()
    loadWeather()
    tableView.refreshControl = refreshControl
    refreshControl?.addTarget(self, action: #selector(refreshWeather), for: .valueChanged)
  }
  
  @objc internal func refreshWeather() {
    // DarkSky API에서 cache를 한시간 동안 잡아주기 때문에 클라이언트에서 처리해주어야 할 필요 X
    loadWeather {
      DispatchQueue.main.async {
        self.refreshControl?.endRefreshing()
      }
    }
    refreshControl?.endRefreshing()
  }

  
  internal func loadWeather(onSuccess: (() -> ())? = nil) {
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

  internal func setCurrentWeatherData(weather: CurrentlyWeather) {
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
  
  @objc internal func removeViewController() {
    let handler = LocationHandler()
    if let latitude = latitude, let longitude = longitude {
      handler.removeLocation(location: Location(latitude: latitude, longitude: longitude, region: region))
    }
    delegate?.removeFromPageViewController(vc: self)
  }
}
