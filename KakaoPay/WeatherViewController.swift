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

  override func viewDidLoad() {
    super.viewDidLoad()
    // TODO: 날씨에 따라서 배경도 다르게
    if let latitude = latitude {
      if latitude == 0.0 {
        view.backgroundColor = .red
      } else if latitude == 1.0 {
        view.backgroundColor = .blue
      }
    }
  }
}
