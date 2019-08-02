//
//  PageViewController.swift
//  KakaoPay
//
//  Created by MinJun KOO on 02/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//
//
//  PageViewController.swift
//  HoneyScreen
//
//  Created by MinJun KOO on 12/06/2019.
//  Copyright © 2019 Buzzvil. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
  lazy var orderedViewControllers: [UIViewController] = {
    return [getNewViewController(latitude: 0.0, longitude: 0.0),
            getNewViewController(latitude: 1.0, longitude: 0.0)]
  }()

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  var pageControl = UIPageControl()
  var resultSearchController: UISearchController? = nil

  override func viewDidLoad() {
    super.viewDidLoad()
    setSearchBar()
    KPLocationManager.sharedManager.checkLocationServices()
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
    searchBar?.placeholder = "Search for places"
    navigationItem.titleView = resultSearchController?.searchBar

    resultSearchController?.hidesNavigationBarDuringPresentation = false
    resultSearchController?.dimsBackgroundDuringPresentation = true
    definesPresentationContext = true

  }

  private func getNewViewController(latitude: Double, longitude: Double) -> WeatherViewController {
    let weatherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController

    weatherViewController.latitude = latitude
    weatherViewController.longitude = longitude
    return weatherViewController
  }

  func configurePageControl() {
    pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 60, width: UIScreen.main.bounds.width, height: 8))
    pageControl.numberOfPages = orderedViewControllers.count
    pageControl.currentPage = 0
    pageControl.tintColor = .blue
    pageControl.pageIndicatorTintColor = .lightGray
    pageControl.currentPageIndicatorTintColor = .blue
    view.addSubview(pageControl)
  }
}

extension PageViewController: ResultTableViewControllerDelegate {
  func addPlace(latitude: Double, longitude: Double) {
    resultSearchController?.searchBar.text = nil
    print("KOOMINJUN")
    // TODO: latitude, longitude 받아서 viewController 추가하기
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
