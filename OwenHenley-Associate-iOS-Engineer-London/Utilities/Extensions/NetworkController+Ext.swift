//
//  NetworkController+Ext.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 07/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import Foundation

extension NetworkController {
    /// Get the requested value from the `Header` plist.
    ///
    /// - Parameter keyname: The key of the header.
    /// - Returns: The value for the key.
    func value(for keyname: String) -> String {
        let filePath = Bundle.main.path(forResource: "ApiValues", ofType: "plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        let value = plist?.object(forKey: keyname) as! String
        return value
    }
}
