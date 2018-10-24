//
//  SafeAreaViewController.swift
//  iPhoneX
//
//  Created by Kautilya on 24/10/18.
//  Copyright © 2018 Kautilya. All rights reserved.
//

import Foundation
import UIKit

class SafeAreaViewController : UIViewController {
    
    @IBOutlet weak var yoLabel: UILabel!
    @IBOutlet weak var eodLabel: UILabel!
    
    
    let prevButton : UIButton = {
        let button = UIButton(type: .system)
        return button
    } ()
    
    let bottomButton : UIButton = {
        let button = UIButton(type: .system)
        return button
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello Safe Area")
        setupView()
    }
    
    
    func setupView () {
        
        setupBottomView()
        
    }
    
    
    func setupBottomView () {
        view.addSubview(prevButton)
        prevButton.backgroundColor = UIColor.red
        prevButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        
        
        view.addSubview(bottomButton)
        bottomButton.backgroundColor = UIColor.orange
        bottomButton.frame = CGRect(x: 100, y: 500, width: 200, height: 50)
    }
}
