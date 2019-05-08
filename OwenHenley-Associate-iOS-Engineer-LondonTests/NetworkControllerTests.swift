//
//  NetworkControllerTests.swift
//  OwenHenley-Associate-iOS-Engineer-LondonTests
//
//  Created by Owen Henley on 08/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import XCTest
@testable import OwenHenley_Associate_iOS_Engineer_London

class NetworkControllerTests: XCTestCase {

    // Need stubs and mocks. Maybe a protocol to assist with this?

    private var networkController: NetworkController?

    override func setUp() {
        networkController = NetworkController.shared
    }

    override func tearDown() {
        networkController = nil
    }
}
