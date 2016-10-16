//
//  ViewController.swift
//  MakeYourOwnAdventure
//
//  Created by Sensehack on 14/10/16.
//  Copyright © 2016 Sensehack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            title: "Start Over",
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(ViewController.startOver))
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startOver() {
        
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }

}

