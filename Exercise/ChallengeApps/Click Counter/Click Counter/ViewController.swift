//
//  ViewController.swift
//  Click Counter
//
//  Created by Sensehack on 25/09/16.
//  Copyright © 2016 Sensehack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var count = 0
    @IBOutlet var label : UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    
    }


    
    @IBAction  func incrementCount()
    {
        count += 1
        self.label.text = "\(count)"
    }
}

