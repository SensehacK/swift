//
//  ViewController.swift
//  TravisCI
//
//  Created by Sensehack on 07/02/19.
//  Copyright © 2019 Sensehack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(piFunction(a: 4))
    }
    
    func piFunction(a: Float) -> Float {
        return a * 3.14
    }


}

