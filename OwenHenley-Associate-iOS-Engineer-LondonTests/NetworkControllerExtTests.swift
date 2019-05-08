//
//  NetworkControllerExtTests.swift
//  OwenHenley-Associate-iOS-Engineer-LondonTests
//
//  Created by Owen Henley on 08/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import XCTest
@testable import OwenHenley_Associate_iOS_Engineer_London

class NetworkControllerExtTests: XCTestCase {

    private var networkController: NetworkController?

    override func setUp() {
        networkController = NetworkController.shared
    }

    override func tearDown() {
        networkController = nil
    }
}

extension NetworkControllerExtTests {
    func testValueReturnsValueStringIfValidKey() {
        // Given
        // guard let networkController = networkController else {
        //     XCTFail("test not set up correctly.")
        //     return
        // }
        
       // Would need stubs and mocks
    }
}
