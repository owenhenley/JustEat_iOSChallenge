//
//  ViewController.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 04/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

/// ViewController Class for the search screen.
class SearchViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!

    // MARK: - Properties
    private var searchResults = [Restaurant]()
    private let cellId = "restaurantCell"

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureSearchBar()
    }

    // MARK: - Actions
    /// Get the users current location.
    ///
    /// - Parameter sender: The gps button.
    @IBAction func locationArrowTapped(_ sender: UIButton) {

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

        cell.restauraunt = searchResults[indexPath.row]

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
        guard let searchText = searchBar.text else {
            // show alert
            return
        }

        // Get list
        NetworkController.shared.fetchRestauraunts(postcode: searchText) { (results) in
            guard let results = results else {
                return
            }

            self.searchResults = results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        searchBar.endEditing(true)
    }
}
