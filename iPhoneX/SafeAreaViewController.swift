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
    @IBOutlet weak var helloButton: UIButton!
    
    var i = 0
    
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
        print("Before Explicit setting Axis", helloButton.frame.origin.y)
        setupView()
    }
    
    
    func setupView () {
        
        setupBottomView()
        print("Hell 2 ", helloButton.frame.origin.y)
    }
    
    
    func setupBottomView () {
        view.addSubview(prevButton)
        prevButton.backgroundColor = UIColor.red
        prevButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        
        
        view.addSubview(bottomButton)
        bottomButton.backgroundColor = UIColor.orange
        bottomButton.frame = CGRect(x: 100, y: 750, width: 200, height: 50)
        
        helloButton.frame.origin.y = 200
        print("After Explicit setting Axis", helloButton.frame.origin.y)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //call random position
        randomLabelPosition()
        
    }
    
    
    @IBAction func randomButtons(_ sender: Any) {
        i += 1
        print("Button Pressed x" , i )
        randomLabelPosition()
        let asse =  2324
        print("AGbnwr", asse)
    }
    
    
    
    
    func randomLabelPosition () {
    
        // setting random x & y values
        let xRandom = Int(arc4random_uniform(700) + 1)
        let yRandom = Int(arc4random_uniform(400) + 1)
        
        //setting the button x & y axis
        helloButton.frame.origin.y = CGFloat(xRandom)
        helloButton.frame.origin.x = CGFloat(yRandom)
        print("After Explicit setting Axis", helloButton.frame.origin.y , helloButton.frame.origin.x)
        
    }
}
