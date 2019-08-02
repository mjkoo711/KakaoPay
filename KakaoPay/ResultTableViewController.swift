//
//  ResultTableViewController.swift
//  KakaoPay
//
//  Created by MinJun KOO on 02/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import UIKit
import MapKit

protocol ResultTableViewControllerDelegate {
  func addPlace(latitude: Double, longitude: Double)
}

class ResultTableViewController: UITableViewController {
  var matchingItems: [MKMapItem] = []
  var delegate: ResultTableViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func parseAddress(selectedItemPlacemark: MKPlacemark) -> String {
    let placemark = selectedItemPlacemark
    let subThoroughfare = placemark.subThoroughfare
    let thoroughfare = placemark.thoroughfare
    let subAdministrativeArea = placemark.subAdministrativeArea
    let administrativeArea = placemark.administrativeArea
    let locality = placemark.locality

    let firstSpace = (subThoroughfare != nil && thoroughfare != nil) ? " " : ""
    let comma = (subThoroughfare != nil || thoroughfare != nil) && (subAdministrativeArea != nil) || (administrativeArea != nil) ? ", " : ""
    let secondSpace = (subAdministrativeArea != nil && administrativeArea != nil) ? " " : ""
    let addressLine = String(format: "%@%@%@%@%@%@%@", subThoroughfare ?? "", firstSpace, thoroughfare ?? "", comma, locality ?? "", secondSpace, administrativeArea ?? "")
    return addressLine
  }
}

extension ResultTableViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return matchingItems.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell")!
    let selectedItemPlacemark = matchingItems[indexPath.row].placemark
    cell.textLabel?.text = selectedItemPlacemark.name
    cell.detailTextLabel?.text = parseAddress(selectedItemPlacemark: selectedItemPlacemark)
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedItem = matchingItems[indexPath.row]
    let latitude = selectedItem.placemark.coordinate.latitude
    let longitude = selectedItem.placemark.coordinate.longitude
    delegate?.addPlace(latitude: latitude, longitude: longitude)
    dismiss(animated: true, completion: nil)
  }
}

extension ResultTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchBarText = searchController.searchBar.text else { return }
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = searchBarText
    request.region = MKCoordinateRegion()
    let search = MKLocalSearch(request: request)
    search.start { (response, error) in
      guard let response = response else { return }
      self.matchingItems = response.mapItems
      self.tableView.reloadData()
    }
  }
}
