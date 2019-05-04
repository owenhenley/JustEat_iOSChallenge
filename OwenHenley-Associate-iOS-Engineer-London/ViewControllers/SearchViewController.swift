//
//  ViewController.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 04/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!

    // MARK: - Properties
    private var searchResults = [String]()
    private let cellId = "restaurantCell"

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - Actions
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
    }
}


// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RestaurantTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}


// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
