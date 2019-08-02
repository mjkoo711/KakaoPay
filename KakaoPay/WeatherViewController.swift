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
    // 여기서도 똑같이 설정해줘야 자연스럽네
    if let latitude = latitude {
      if latitude == 0.0 {
        view.backgroundColor = .red
      } else if latitude == 1.0 {
        view.backgroundColor = .blue
      } else {
        view.backgroundColor = .green
      }
    }
  }
}
