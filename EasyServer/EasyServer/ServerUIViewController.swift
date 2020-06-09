//
//  ServerUIViewController.swift
//  EasyServer
//
//  Created by Kautilya on 04/01/19.
//  Copyright © 2019 Kautilya. All rights reserved.
//

import UIKit

class ServerUIViewController: UIViewController {

    @IBOutlet weak var vegSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set Switch to green Veg only.
        vegSwitch.isEnabled = false
    }
    
    
    @IBAction func vegSwitch(_ sender: UISwitch) {
        if sender.isOn {
            view.backgroundColor = UIColor.red;
        }
        else {
            view.backgroundColor = UIColor.green;
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
