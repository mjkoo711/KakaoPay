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
    KPLocationManager.sharedManager.checkLocationServices()
    // TODO : 만약 리스트가 없다면, 검색하게하고
    // TODO : 리스트가 있다면, 그 것을 보여주자 PageController로 보여주는 것이 제일 무난할듯
//    loadWeather(latitude: 37.0, longitude: 127.0)
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

