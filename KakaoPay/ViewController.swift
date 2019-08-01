//
//  ViewController.swift
//  KakaoPay
//
//  Created by 구민준 on 01/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    loadWeather(latitude: 37.0, longitude: 127.0)
  }

  func loadWeather(latitude: Double, longitude: Double) {
    let request = WeatherRequest()
    request.loadWeather(latitude: latitude, longitude: longitude, onSuccess: { (weather) in
      // TODO
    }, onFailure: { (error) in
      // TODO
    })
  }
}

