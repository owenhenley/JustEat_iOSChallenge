//
//  ViewController.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 04/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit
import CoreLocation

/// ViewController Class for the search screen.
class SearchViewController: UIViewController {

    // MARK: - Elements
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    private let indicator = UIActivityIndicatorView(style: .whiteLarge)

    // MARK: - Properties
    private var searchResults = [Restaurant]()
    private let cellId = "restaurantCell"
    private var locationManager = CLLocationManager()
    var postalCode = ""

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureSearchBar()
    }
}

// MARK: - Private Methods
extension SearchViewController {
    /// Set up the table view.
    ///
    /// This will configure the delegate, datasource and register the `RestaurantTableViewCell` nib
    /// to the table view cell.
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "RestaurantTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "restaurantCell")

        tableView.keyboardDismissMode = .onDrag
    }
}


// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return searchResults.isEmpty ? 250 : 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Enter a valid Postal Code or use \nGPS to find your location."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }

}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RestaurantTableViewCell else {
            return UITableViewCell()
        }

        let sortedResults = searchResults.sorted { (restaurant, _) -> Bool in
            return restaurant.isOpenNow
        }

        cell.restauraunt = sortedResults[indexPath.row]

        return cell
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {

    /// Setup searchbar configuration.
    func configureSearchBar() {
        searchBar.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            missingPostcodeAlert()
            return
        }

        // Get list
        handleActivityMonitor()
        NetworkController.shared.fetchRestauraunts(postcode: searchText) { (results) in
            guard let results = results else {
                return
            }

            self.searchResults = results
            DispatchQueue.main.async {
                self.handleActivityMonitor()
                self.tableView.reloadData()
            }
        }

        searchBar.endEditing(true)
    }
}

// MARK: - CLLocationManagerDelegate
extension SearchViewController: CLLocationManagerDelegate {
    /// Get the users current location.
    ///
    /// - Parameter sender: The gps button.
    @IBAction func locationArrowTapped(_ sender: UIButton) {
        handleActivityMonitor()
        setupCoreLocation()
        getCurrentLocation {
            NetworkController.shared.fetchRestauraunts(postcode: self.postalCode) { (results) in
                guard let results = results else { return }

                DispatchQueue.main.async {
                    self.searchResults = results
                    self.searchBar.text = self.postalCode

                    self.tableView.reloadData()
                    let topIndex = IndexPath(row: 0, section: 0)
                    self.tableView.scrollToRow(at: topIndex, at: .top, animated: true)
                    self.handleActivityMonitor()
                }
            }
        }
    }

    /// Setup CoreLocation.
    func setupCoreLocation () {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    /// Get the users current location.
    ///
    /// This will get the users postal code.
    /// - Parameter completion: A closure to do some networking in.
    func getCurrentLocation(completion: @escaping () -> Void) {
        guard let location = locationManager.location?.coordinate else {
            return
        }

        let eventLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(eventLocation) { (placemarks, error) in
            if let placemark = placemarks?.first, let postCode = placemark.postalCode {
                self.postalCode = postCode
                completion()
            }
        }
    }
}

private extension SearchViewController {
    func missingPostcodeAlert() {
        let ac = UIAlertController(title: "Oops", message: "You need to input a postal code to get results.\n\nPlease try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Try Again", style: .cancel))
        present(ac, animated: true)
    }

    func handleActivityMonitor() {
        if indicator.isAnimating {
            indicator.stopAnimating()
        } else {
            indicator.color = .black
            indicator.startAnimating()
            indicator.hidesWhenStopped = true
            view.addSubview(indicator)
            indicator.centerInSuperview()
        }
    }
}
