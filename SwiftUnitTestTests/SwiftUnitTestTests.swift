//
//  SwiftUnitTestTests.swift
//  SwiftUnitTestTests
//
//  Created by Kautilya on 07/02/19.
//  Copyright © 2019 Kautilya. All rights reserved.
//

import XCTest
@testable import SwiftUnitTest

class SwiftUnitTestTests: XCTestCase {

    func testHelloWorld() {
        var helloWorld: String?
        
        XCTAssertNil(helloWorld)
        
        helloWorld = "hello Sensehack"
//        XCTAssertEqual(helloWorld, "hello World")
        
        XCTAssertEqual(helloWorld, "hello Sensehack")
    }
    
    func testSquareInt() {
        let value = 3
        let squaredResult = value.square()
        XCTAssertEqual(squaredResult, 9)
        
    }

}
