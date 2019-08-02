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
//    if let latitude = latitude {
//      if latitude == 0.0 {
//        view.backgroundColor = .red
//      } else if latitude == 1.0 {
//        view.backgroundColor = .blue
//      } else {
//        view.backgroundColor = .green
//      }
//    }
  }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: UITableViewCell = UITableViewCell(frame: CGRect.zero)
    
    if indexPath.row == 0 {
      cell = tableView.dequeueReusableCell(withIdentifier: "TodayForecastTableViewCell") as! TodayForecastTableViewCell
    } else if indexPath.row == 1 {
      cell = tableView.dequeueReusableCell(withIdentifier: "DailyForecastTableViewCell") as! DailyForecastTableViewCell
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 122
    } else if indexPath.row == 1 {
      return 54 * 8 + 4 * 8
    }
    return 0
  }
}

