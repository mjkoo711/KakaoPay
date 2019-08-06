//
//  PageViewController.swift
//  KakaoPay
//
//  Created by MinJun KOO on 02/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import UIKit
import CoreLocation

class PageViewController: UIPageViewController {
  var orderedViewControllers: [UIViewController] = []

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  var resultSearchController: UISearchController? = nil

  override func viewDidLoad() {
    super.viewDidLoad()
    orderedViewControllers = loadOrderedViewControllers()
    view.setGradientLayer()
    setSearchBar()
    KPLocationManager.shared.delegate = self
    showCurrentLocationWeather()
    self.delegate = self
    self.dataSource = self

    if let firstViewController = orderedViewControllers.first {
      setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
    } else {
      setViewControllers([getEmptyViewController()], direction: .forward, animated: false, completion: nil)
    }
  }
  
  private func loadOrderedViewControllers() -> [UIViewController] {
    let storage = LocationStorage()
    let locations = storage.loadLocations()
    var viewControllers: [UIViewController] = []
    for location in locations {
    viewControllers.append(getNewViewController(latitude: location.latitude, longitude: location.longitude, region: location.region))
    }
    return viewControllers
  }

  private func setSearchBar() {
    let locationSearchTableViewController =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultTableViewController") as! ResultTableViewController
    locationSearchTableViewController.delegate = self
    resultSearchController = UISearchController(searchResultsController: locationSearchTableViewController)
    resultSearchController?.searchResultsUpdater = locationSearchTableViewController

    let searchBar = resultSearchController?.searchBar
    searchBar?.sizeToFit()
    searchBar?.placeholder = "지역을 입력해보세요"
    navigationItem.titleView = resultSearchController?.searchBar

    resultSearchController?.hidesNavigationBarDuringPresentation = false
    resultSearchController?.dimsBackgroundDuringPresentation = true
    definesPresentationContext = true

  }

  internal func getNewViewController(latitude: Double, longitude: Double, region: String, current: Bool = false) -> WeatherViewController {
    let weatherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController

    weatherViewController.latitude = latitude
    weatherViewController.longitude = longitude
    weatherViewController.region = region
    weatherViewController.isCurrentLocation = current
    
    weatherViewController.delegate = self
    return weatherViewController
  }
  
  internal func getEmptyViewController() -> EmptyViewController {
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmptyViewController") as! EmptyViewController
    
    return viewController
  }
}
