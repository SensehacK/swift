//
//  ViewController.swift
//  AlamafireTest
//
//  Created by Kautilya on 10/05/18.
//  Copyright © 2018 Kautilya. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "https://restcountries.eu/rest/v2/all")
        
        Alamofire.request(url!).responseJSON { (response) in
            let result = response.result
            print("Alamofire Request Inside")
            print("Result returned by JSON Website" , result)
            print("Result printed again" , result)
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

