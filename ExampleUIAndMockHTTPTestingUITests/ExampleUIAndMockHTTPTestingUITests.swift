//
//  ExampleUIAndMockHTTPTestingUITests.swift
//  ExampleUIAndMockHTTPTestingUITests
//
//  Created by Robert Collins on 27/09/2015.
//  Copyright © 2015 Robert Collins. All rights reserved.
//

import XCTest
import OHHTTPStubs

class ExampleUIAndMockHTTPTestingUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    func testExample() {
        // Given
        let app = XCUIApplication()
        OHHTTPStubs.stubRequestsPassingTest({$0.URL!.host == "bing.com"}) { _ in
            return OHHTTPStubsResponse(data: NSData(), statusCode: 404, headers: nil)
        }
        
        let requestButton = app.buttons["Make HTTP Request"]
        
        // When
        requestButton.tap()
        
        // Then
        let expected = "404"
        let testPredicate = NSPredicate(format: "label == '\(expected)'")
        let object = app.staticTexts.elementMatchingType(.Any, identifier: "resultLabel")
        
        expectationForPredicate(testPredicate, evaluatedWithObject: object, handler: nil)
        waitForExpectationsWithTimeout(5, handler: nil)
    }
}
