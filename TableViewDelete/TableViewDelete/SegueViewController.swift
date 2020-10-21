//
//  SegueViewController.swift
//  TableViewDelete
//
//  Created by Kautilya on 03/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class SegueViewController: UIViewController {
    
    @IBOutlet var heroLabel: UILabel!
    
    var segueString = "Sensehack"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        heroLabel.text = segueString
        
        // Do any additional setup after loading the view.
    }

    
    
    
    
}
