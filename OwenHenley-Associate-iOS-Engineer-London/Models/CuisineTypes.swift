//
//  CuisineTypes.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 06/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import Foundation

/// An object from `Restaurant` that holds Cuisine Types.
struct CuisineTypes: Decodable {
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
    }
}
