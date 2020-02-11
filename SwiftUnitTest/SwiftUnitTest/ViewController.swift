//
//  ViewController.swift
//  SwiftUnitTest
//
//  Created by Kautilya on 07/02/19.
//  Copyright © 2019 Kautilya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(2.square())
    }

}

extension Int {
    func square() -> Int {
        return self * self
    }
}

