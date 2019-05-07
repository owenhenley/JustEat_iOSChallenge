//
//  SearchResultsDataSource.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 07/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class SearchResultsDataSource: NSObject, UITableViewDataSource {

    let cellId = "restaurantCell"
    var searchResults = [Restaurant]()

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
