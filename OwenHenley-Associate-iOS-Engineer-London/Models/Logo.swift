//
//  Logo.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 06/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import Foundation

/// An object that holds the `Restaurant` logo.
///
/// Note: Images are .`gif`'s.
struct Logo: Decodable {
    let logoURLString: String?

    enum CodingKeys: String, CodingKey {
        case logoURLString = "StandardResolutionURL"
    }
}
