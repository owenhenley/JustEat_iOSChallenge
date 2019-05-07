//
//  ViewController.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 06/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit
import CoreLocation

/// ViewController Class for the search screen.
class SearchViewController: UIViewController {

    // MARK: - Views
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

    // MARK: - Properties
    private var resultsDataSource = SearchResultsDataSource()
    private var locationManager = CLLocationManager()
    private var postcode = ""
    private var locationAccessSetup = false

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureSearchBar()
    }

    // MARK: - Methods
    /// Show an alert reminding a user to enter a postcode.
    private func missingPostcodeAlert() {
        showAlert(title: "Oops",
                  message: "You need to input a postcode to get results.\n\nPlease try again.",
                  actionTitle: "Try Again")
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return resultsDataSource.searchResults.isEmpty ? 250 : 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.addPlaceholder(with: "Enter a valid Postcode or use \nGPS to find your location.")
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            missingPostcodeAlert()
            return
        }

        // Get list
        handle(activityIndicator)
        NetworkController.shared.fetchRestauraunts(postcode: searchText) { (results) in
            guard let results = results else {
                return
            }

            self.resultsDataSource.searchResults = results
            DispatchQueue.main.async {
                self.handle(self.activityIndicator)
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
        handle(activityIndicator)
        authLocationAccess()
        getCurrentLocation {
            NetworkController.shared.fetchRestauraunts(postcode: self.postcode) { (results) in
                guard let results = results else { return }

                DispatchQueue.main.async {
                    self.resultsDataSource.searchResults = results
                    self.searchBar.text = self.postcode

                    let topIndex = IndexPath(row: 0, section: 0)
                    self.tableView.scrollToRow(at: topIndex, at: .top, animated: true)
                    self.tableView.reloadData()
                    self.handle(self.activityIndicator)
                }
            }
        }
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
                self.postcode = postCode
                completion()
            }
        }
    }
}

// MARK: - Setup self
private extension SearchViewController {
    /// Set up the table view.
    ///
    /// This will configure the delegate, datasource and register the `RestaurantTableViewCell` nib
    /// to the table view cell.
    func setupTableView() {
        tableView.dataSource = resultsDataSource
        tableView.delegate = self

        let nib = UINib(nibName: "RestaurantTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "restaurantCell")

        tableView.keyboardDismissMode = .onDrag
    }

    /// Setup search bar configuration.
    func configureSearchBar() {
        searchBar.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        searchBar.delegate = self
    }

    /// Setup CoreLocation.
    func authLocationAccess () {
        if locationAccessSetup {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
}
