//
//  PageViewControllerExtentions.swift
//  KakaoPay
//
//  Created by 구민준 on 04/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import UIKit
import CoreLocation

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
      setViewControllers([getEmptyViewController()], direction: .forward, animated: false)
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
    })
  }
  
  func dismissCurrentLocationWeatherViewController() {
    if let firstViewController = orderedViewControllers.first as? WeatherViewController, firstViewController.isCurrentLocation == true {
      orderedViewControllers.remove(at: 0)
      if orderedViewControllers.count == 0 {
        setViewControllers([getEmptyViewController()], direction: .forward, animated: false)
        updatePageControl(numberOfPages: 0, currentPage: 0)
      } else {
        DispatchQueue.main.async {
          self.setViewControllers([self.orderedViewControllers[0]], direction: .forward, animated: false, completion: nil)
          self.updatePageControl(numberOfPages: self.orderedViewControllers.count, currentPage: 0)
        }
      }
    }
  }
}
