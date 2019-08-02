
//  ResultTableViewController.swift
//  KakaoPay
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

extension ResultTableViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell")!
    let searchResult = searchResults[indexPath.row]
    cell.textLabel?.text = searchResult.title
    cell.detailTextLabel?.text = searchResult.subtitle
    return cell
    
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let request = MKLocalSearch.Request(completion: searchResults[indexPath.row])
    request.region = MKCoordinateRegion()
    let search = MKLocalSearch(request: request)
    search.start { (response, error) in
      guard let response = response else { return }
      let latitude = response.mapItems[0].placemark.coordinate.latitude
      let longitude = response.mapItems[0].placemark.coordinate.longitude
      self.delegate?.addPlace(latitude: latitude, longitude: longitude, region: self.searchResults[indexPath.row].title)
      self.dismiss(animated: true, completion: nil)
    }
  }
}

extension ResultTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchBarText = searchController.searchBar.text else { return }
    searchCompleter.queryFragment = searchBarText
  }
}

extension ResultTableViewController: MKLocalSearchCompleterDelegate {
  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    searchResults = completer.results.filter { $0.subtitle.count == 0 }
    tableView.reloadData()
  }
}
