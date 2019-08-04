//
//  UIViewExtensions.swift
//  KakaoPay
//
//  Created by 구민준 on 04/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import UIKit

extension UIView {
  func setGradientLayer() {
    backgroundColor = .clear
    let colorTop: UIColor = .white
    let colorBottom: UIColor =  UIColor.init(red: 18/255.0, green: 144/255.0, blue: 255/255.0, alpha: 1.0)
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
    gradientLayer.locations = [0, 1]
    gradientLayer.frame = bounds

    layer.insertSublayer(gradientLayer, at: 0)
  }
}
