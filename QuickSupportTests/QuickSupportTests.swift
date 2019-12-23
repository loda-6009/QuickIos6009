//
//  QuickSupportTests.swift
//  QuickSupportTests
//
//  Created by brownsoo han on 08/05/2019.
//  Copyright © 2019 6009. All rights reserved.
//

import XCTest
@testable import QuickSupport

class QuickSupportTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTwoDigit() {
        XCTAssertEqual((-10).twoDigitString(), "-10")
        XCTAssertEqual((-8).twoDigitString(), "-08")
        XCTAssertEqual(0.twoDigitString(), "00")
        XCTAssertEqual(5.twoDigitString(),  "05")
        XCTAssertEqual(11.twoDigitString(), "11")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
