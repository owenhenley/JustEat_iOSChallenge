//
//  Restaurants.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 06/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import Foundation

/// An object with all data for a restaurant.
struct Restaurant: Decodable {
    let name: String?
    let isOpenNow: Bool
    let rating: Double?
    let cuisineTypes: [CuisineTypes]?
    let logo: [Logo]?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case isOpenNow = "IsOpenNow"
        case rating = "RatingStars"
        case cuisineTypes = "CuisineTypes"
        case logo = "Logo"
    }
}
