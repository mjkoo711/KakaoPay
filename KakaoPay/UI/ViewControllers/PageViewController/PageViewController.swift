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
  lazy var orderedViewControllers: [UIViewController] = {
    let locations = LocationHandler().loadLocations()
    var viewControllers: [UIViewController] = []
    for location in locations {
      viewControllers.append(getNewViewController(latitude: location.latitude, longitude: location.longitude, region: location.region))
    }
    return viewControllers
  }() 

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  var pageControl = UIPageControl()
  var resultSearchController: UISearchController? = nil

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setSearchBar()
    KPLocationManager.sharedManager.delegate = self
    showCurrentLocationWeather()
    self.delegate = self
    self.dataSource = self
    configurePageControl()

    if let firstViewController = orderedViewControllers.first {
      setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
    }
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

  internal func configurePageControl() {
    pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 60, width: UIScreen.main.bounds.width, height: 8))
    pageControl.numberOfPages = orderedViewControllers.count
    pageControl.currentPage = 0
    pageControl.tintColor = .blue
    pageControl.pageIndicatorTintColor = .lightGray
    pageControl.currentPageIndicatorTintColor = .blue
    view.addSubview(pageControl)
  }
  
  internal func updatePageControl(numberOfPages: Int, currentPage: Int) {
    pageControl.numberOfPages = numberOfPages
    pageControl.currentPage = currentPage
  }
}
