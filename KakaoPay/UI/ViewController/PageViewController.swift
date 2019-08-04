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

  private func getNewViewController(latitude: Double, longitude: Double, region: String, current: Bool = false) -> WeatherViewController {
    let weatherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController

    weatherViewController.latitude = latitude
    weatherViewController.longitude = longitude
    weatherViewController.region = region
    weatherViewController.isCurrentLocation = current
    
    weatherViewController.delegate = self
    return weatherViewController
  }

  private func configurePageControl() {
    pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 60, width: UIScreen.main.bounds.width, height: 8))
    pageControl.numberOfPages = orderedViewControllers.count
    pageControl.currentPage = 0
    pageControl.tintColor = .blue
    pageControl.pageIndicatorTintColor = .lightGray
    pageControl.currentPageIndicatorTintColor = .blue
    view.addSubview(pageControl)
  }
  
  private func updatePageControl(numberOfPages: Int, currentPage: Int) {
    pageControl.numberOfPages = numberOfPages
    pageControl.currentPage = currentPage
  }
}

extension PageViewController: ResultTableViewControllerDelegate {
  func addPlace(latitude: Double, longitude: Double, region: String) {
    resultSearchController?.searchBar.text = nil
    orderedViewControllers.append(getNewViewController(latitude: latitude, longitude: longitude, region: region))

    if let lastViewController = orderedViewControllers.last {
      setViewControllers([lastViewController], direction: .reverse, animated: false, completion: nil)
      updatePageControl(numberOfPages: orderedViewControllers.count, currentPage: orderedViewControllers.count)
    }
  }
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let index = orderedViewControllers.firstIndex(of: viewController) else { return nil }
    let previousIndex = index - 1
    guard previousIndex >= 0 else { return nil }
    guard orderedViewControllers.count > previousIndex else { return nil }
    return orderedViewControllers[previousIndex]
  }

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let index = orderedViewControllers.firstIndex(of: viewController) else { return nil }
    let nextIndex = index + 1
    let totalCount = orderedViewControllers.count

    guard totalCount != nextIndex else { return nil }
    guard totalCount > nextIndex else { return nil }

    return orderedViewControllers[nextIndex]
  }

  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    let pageContentViewController = pageViewController.viewControllers![0]
    pageControl.currentPage = orderedViewControllers.firstIndex(of: pageContentViewController)!

    // TODO: pageController의 backgroundColor 여기서 설정
  }
}

extension PageViewController: WeatherViewControllerDelegate {
  func removeFromPageViewController(vc viewController: UIViewController) {
    guard let index = orderedViewControllers.firstIndex(of: viewController) else { return }
    orderedViewControllers.remove(at: index)
    
    if let firstViewController = orderedViewControllers.first {
      setViewControllers([firstViewController], direction: .forward, animated: false) { (bool) in
        self.updatePageControl(numberOfPages: self.orderedViewControllers.count, currentPage: 0)
      }
    } else {
      setViewControllers([PageViewController()], direction: .forward, animated: false)
      updatePageControl(numberOfPages: 0, currentPage: 0)
    }
  }
}

extension PageViewController: KPLocationManagerDelegate {
  func isUpdateRequired(location: CLLocation) -> Bool {
    if let firstViewController = self.orderedViewControllers.first as? WeatherViewController, firstViewController.isCurrentLocation == true {
      let newLatitude = ((location.coordinate.latitude * 100).rounded()) / 100
      let newLongitude = ((location.coordinate.longitude * 100).rounded()) / 100
      if let oldLatitude = firstViewController.latitude, let oldLongitude = firstViewController.longitude, oldLatitude == newLatitude, oldLongitude == newLongitude {
        return false
      } else { return true }
    } else { return false }
  }
  
  func showCurrentLocationWeather() {
    KPLocationManager.sharedManager.checkLocationServices(onSuccess: { (location) in
      if let firstViewController = self.orderedViewControllers.first as? WeatherViewController, firstViewController.isCurrentLocation == true {
        self.orderedViewControllers.remove(at: 0)
      }
      
      self.orderedViewControllers.insert(self.getNewViewController(latitude: location.latitude, longitude: location.longitude, region: location.region, current: true), at: 0)
      
      if let firstViewController = self.orderedViewControllers.first {
        DispatchQueue.main.async {
          self.setViewControllers([firstViewController], direction: .forward, animated: false, completion: nil)
          self.updatePageControl(numberOfPages: self.orderedViewControllers.count, currentPage: 0)
        }
      }
    }, onFailure: {
      // Todo
    })
  }
  
  func dismissCurrentLocationWeatherViewController() {
    if let firstViewController = orderedViewControllers.first as? WeatherViewController, firstViewController.isCurrentLocation == true {
      orderedViewControllers.remove(at: 0)
      if orderedViewControllers.count == 0 {
        setViewControllers([PageViewController()], direction: .forward, animated: false)
        updatePageControl(numberOfPages: 0, currentPage: 0)
      } else {
        setViewControllers([firstViewController], direction: .forward, animated: false, completion: nil)
        updatePageControl(numberOfPages: orderedViewControllers.count, currentPage: 0)
      }
    }
  }
}
