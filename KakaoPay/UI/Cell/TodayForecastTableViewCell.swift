//
//  TodayForecastTableViewCell.swift
//  KakaoPay
//
//  Created by 구민준 on 02/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import UIKit

class TodayForecastTableViewCell: UITableViewCell {
  @IBOutlet weak var collectionView: UICollectionView!
  
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

extension TodayForecastTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // TODO
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayForecastCollectionViewCell", for: indexPath) as! TodayForecastCollectionViewCell
    return cell
  }
}

extension TodayForecastTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 84, height: 120) // 122가 되면 warning이 뜨네,,
  }
}
