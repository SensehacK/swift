//
//  loggedVC.swift
//  UserDefaults
//
//  Created by Kautilya on 12/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import Foundation
import  UIKit

class loggedVC : UIViewController {
    
    
    @IBOutlet var userLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        userLabel.text = UserDefaults.standard.object(forKey: "username") as! String?
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
}
