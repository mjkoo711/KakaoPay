
//  ResultTableViewController.swift
//  MJWeather
//
//  Created by MinJun KOO on 02/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import UIKit
import MapKit

protocol ResultTableViewControllerDelegate {
  func addPlace(latitude: Double, longitude: Double, region: String)
}

class ResultTableViewController: UITableViewController {
  var delegate: ResultTableViewControllerDelegate?
  
  var matchingItems: [MKMapItem] = []

  var searchCompleter = MKLocalSearchCompleter()
  var searchResults = [MKLocalSearchCompletion]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchCompleter.delegate = self
  }
}
