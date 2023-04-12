//
//  TableNewViewController.swift
//  TodoList
//
//  Created by Kautilya on 05/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class TableNewViewController: UIViewController {

    @IBOutlet var firstLabel: UILabel!
    
    @IBOutlet var secondLabel: UILabel!
    
    var passedData : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstLabel.text = "How You Doing?"
        
        secondLabel.text = passedData
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
