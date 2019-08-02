//
//  HourlyForecastTableViewCell.swift
//  KakaoPay
//
//  Created by 구민준 on 02/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import UIKit

class HourlyForecastTableViewCell: UITableViewCell {
  @IBOutlet weak var collectionView: UICollectionView!
  var hourlyWeather: HourlyWeather?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}

extension HourlyForecastTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let weather = hourlyWeather else { return 0 }
    return weather.hourlyData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyForecastCollectionViewCell", for: indexPath) as! HourlyForecastCollectionViewCell
    guard let weather = hourlyWeather else { return cell }
    let data = weather.hourlyData[indexPath.row]
    
    cell.timeLabel.text = "\(data.time ?? 0)"
    cell.temperatureLabel.text = "\(data.temperature ?? 0)"
    cell.weatherImageView.image = UIImage(named: data.iconName ?? "")
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("KOO")
  }
}

extension HourlyForecastTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 84, height: 120) // 122가 되면 warning이 뜨네,,
  }
}
