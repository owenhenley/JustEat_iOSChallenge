//
//  Restaurants.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 05/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import Foundation

/// Top level of the REST endpoint.
struct TopLevelDictionary: Decodable {
    let restaurants: [Restaurant]

    enum CodingKeys: String, CodingKey {
        case restaurants = "Restaurants"
    }
}

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

/// An object from `Restaurant` that holds Cuisine Types.
struct CuisineTypes: Decodable {
    let name: String?
    enum CodingKeys: String, CodingKey {
        case name = "Name"
    }
}

/// An object that holds the `Restaurant` logo. NB: Images are .`gif`'s
struct Logo: Decodable {
    let logoURLString: String?

    enum CodingKeys: String, CodingKey {
        case logoURLString = "StandardResolutionURL"
    }
}
