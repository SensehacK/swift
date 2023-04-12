//
//  SegueViewController.swift
//  CollectionViewR
//
//  Created by Kautilya on 08/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import Foundation
import UIKit


class SegueViewController : UIViewController
{
    
    @IBOutlet var buttonLabel: UILabel!
    var buttonText : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonLabel.text = buttonText
    }
    
    
    
    
    
    
}
