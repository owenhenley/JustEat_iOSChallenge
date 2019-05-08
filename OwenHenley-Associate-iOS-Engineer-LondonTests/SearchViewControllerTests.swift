//
//  SearchViewControllerTests.swift
//  OwenHenley-Associate-iOS-Engineer-LondonTests
//
//  Created by Owen Henley on 08/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import XCTest
@testable import OwenHenley_Associate_iOS_Engineer_London

class SearchViewControllerTests: XCTestCase {

    private var searchVC: SearchViewController?

    override func setUp() {
        searchVC = SearchViewController()
    }

    override func tearDown() {
        searchVC = nil
    }
}

extension SearchResultsDataSourceTests {

    // test showAlert gets called when missingPostcodeAlert is called

    // test fetchRestauants is called when search is tapped

    // test authLocationAccess is called when location arrow is tapped

    // test getCurrentLocation  is called when location arrow is tapped

    // test fetchRestauants is called when location arrow is tapped

}
