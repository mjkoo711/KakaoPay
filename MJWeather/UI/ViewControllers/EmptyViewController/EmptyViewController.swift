//
//  EmptyViewController.swift
//  MJWeather
//
//  Created by 구민준 on 06/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import UIKit

class EmptyViewController: UIViewController {
  @IBOutlet weak var button: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func buttonTapped(_ sender: Any) {
    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
      return
    }
    if UIApplication.shared.canOpenURL(settingsUrl) {
      UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
        print(success)
      })
    }
  }
  
}
