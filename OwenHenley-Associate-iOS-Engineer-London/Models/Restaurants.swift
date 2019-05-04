//
//  Restaurants.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 05/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import Foundation

struct Restaurants {
    let name: String
    let rating: Double
    let cuisineTypes: [CuisineTypes]

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case rating = "RatingStars"
        case cousineTypes = "CousineTypes"
    }

    struct CuisineTypes {
        let name: String

        enum CodingKeys: String, CodingKey {
            case name = "Name"
        }
    }
}
