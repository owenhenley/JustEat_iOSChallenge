//
//  TopLevelDictionary.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 06/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import Foundation

/// Top level of the REST endpoint.
///
/// JSON link: [Just Eat REST API endpoint](https://public.je-apis.com/restaurants?q=se19)
struct TopLevelDictionary: Decodable {
    let restaurants: [Restaurant]

    enum CodingKeys: String, CodingKey {
        case restaurants = "Restaurants"
    }
}
