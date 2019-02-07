//
//  TravisCITests.swift
//  TravisCITests
//
//  Created by Sensehack on 07/02/19.
//  Copyright © 2019 Sensehack. All rights reserved.
//

import XCTest
@testable import TravisCI

class TravisCITests: XCTestCase {
    func testTravisCI() {
        let a1 = 5
        print()
        // Default method of creating class object
        let a4 = ViewController()
        let b = a4.piFunction(a: 4)
        let b1 = a4.piFunction(a: Float(a1))
        
        // shorthand function of creating class objects
        let result = ViewController().piFunction(a: 6)
        let result2 = ViewController().piFunction(a: 5)
        print(b)
        print(b1)
        print(result)
        //        let result = ViewController.piFunction(a: a1)
        print("Selfs 2")
        //        print(result)
        
        //        XCTAssertEqual(b1, result2)
        //        XCTAssertEqual(b1, result)
    }
}
