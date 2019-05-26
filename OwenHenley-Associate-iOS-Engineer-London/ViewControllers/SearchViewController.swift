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
class SearchViewController: BaseViewController {

    // MARK: - Views
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

    // MARK: - Properties
    private let networkController = NetworkController()
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

    /// Scroll to top of the table view.
    private func scrollToTop() {
        if self.tableView.visibleCells.count > 0 {
            let topIndex = IndexPath(row: 0, section: 0)
            self.tableView.scrollToRow(at: topIndex, at: .top, animated: true)
        }
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
        handle(activityIndicator, isActive: true)
        networkController.fetchRestauraunts(postcode: searchText) { result in
            defer {
                self.handle(self.activityIndicator, isActive: false)
            }

            switch result {
            case.success(let results):
                self.resultsDataSource.searchResults = results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.scrollToTop()
                }
            case .failure(let error):
                print("Error: \(#file), \(#function), \(#line), Message: \(error). \(error.localizedDescription)")
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
        handle(activityIndicator, isActive: true)
        authLocationAccess()
        getCurrentLocation {
            self.networkController.fetchRestauraunts(postcode: self.postcode) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }

                defer {
                    self?.handle(strongSelf.activityIndicator, isActive: false)
                }

                switch result {
                case .success(let results):
                    self?.resultsDataSource.searchResults = results
                    DispatchQueue.main.async {
                        self?.searchBar.text = self?.postcode
                        self?.tableView.reloadData()
                        self?.scrollToTop()
                    }
                case .failure(let error):
                    print("Error: \(#file), \(#function), \(#line), Message: \(error). \(error.localizedDescription)")
                }
            }
        }
    }

    /// Get the users current location.
    ///
    /// This will get the users postal code.
    func getCurrentLocation(completion: @escaping () -> Void) {
        guard let location = locationManager.location?.coordinate else {
            print("Error getting location.")
            return
        }

        let eventLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(eventLocation) { [weak self] placemarks, error in
            if let error = error {
                print("Error: \(#file), \(#function), \(#line), Message: \(error). \(error.localizedDescription)")
                self?.showAlert(title: "Error", message: "Could not get current location.", actionTitle: "OK")
                return
            }

            if let placemark = placemarks?.first, let postCode = placemark.postalCode {
                self?.postcode = postCode
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
