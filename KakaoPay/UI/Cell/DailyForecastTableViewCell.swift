//
//  DailyForecastTableViewCell.swift
//  KakaoPay
//
//  Created by 구민준 on 02/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
  @IBOutlet weak var collectionView: UICollectionView!
  var dailyWeather: DailyWeather?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.delegate = self
    collectionView.dataSource = self
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}

extension DailyForecastTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let weather = dailyWeather else { return 0 }
    return weather.hourlyData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyForecastCollectionViewCell", for: indexPath) as! DailyForecastCollectionViewCell
    guard let weather = dailyWeather else { return cell }
    let data = weather.hourlyData[indexPath.row]
    
    cell.dateLabel.text = "\(data.time ?? 0)"
    cell.minTemperatureLabel.text = "\(data.temperatureMin ?? 0)"
    cell.maxTemperatureLabel.text = "\(data.temperatureMax ?? 0)"
    cell.weatherImageView.image = UIImage(named: data.iconName ?? "")
    
    return cell
  }
  
  
}
