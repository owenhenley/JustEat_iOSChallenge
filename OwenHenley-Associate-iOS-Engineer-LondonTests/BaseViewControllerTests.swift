//
//  BaseViewControllerTests.swift
//  OwenHenley-Associate-iOS-Engineer-LondonTests
//
//  Created by Owen Henley on 08/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import XCTest
@testable import OwenHenley_Associate_iOS_Engineer_London

class BaseViewControllerTests: XCTestCase {

    private var baseVC: BaseViewController?

    override func setUp() {
        baseVC = BaseViewController()
    }

    override func tearDown() {
       baseVC = nil
    }
}

// MARK: - handle(_ activityIndicatior:) tests
extension BaseViewControllerTests {
    func testHandleStartsActivityIndicatorAnimation() {
        // Given
        guard let baseVC = baseVC else {
            XCTFail("test not set up correctly.")
            return
        }

        let expectedIndicator = UIActivityIndicatorView()

        // When
        baseVC.handle(expectedIndicator)

        // Then
        XCTAssertTrue(expectedIndicator.isAnimating == true)
    }

    func testHandleStopsAnimationWhenCurrentlyAnimating() {
        // Given
        guard let baseVC = baseVC else {
            XCTFail("test not set up correctly.")
            return
        }

        let expectedIndicator = UIActivityIndicatorView()
        expectedIndicator.startAnimating()

        // When
        baseVC.handle(expectedIndicator)

        // Then
        XCTAssertTrue(expectedIndicator.isAnimating == false)
    }

    // test the vc has a child indicatior view
        // Would need mocks

    // test the vc removed a child indicatior view
        // Would need mocks
}

// MARK: - showAlert(title:, message:, actionTitle:) tests
extension BaseViewControllerTests {
   // Would need mocks
}

// MARK: - addPlaceholder(with:) tests
extension BaseViewControllerTests {
    // Would need mocks
}
