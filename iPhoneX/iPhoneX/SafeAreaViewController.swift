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
        randomLabelPosition(person: 0)
        
    }
    
    
    @IBAction func randomButtons(_ sender: Any) {
        i += 1
        print("Button Pressed x" , i )
        
//        let asse =  2324
//        print("AGbnwr", asse)
        
        /*
        var n = [2,3,5,6,7,8,8,9,9,9]
        
        //different for array index numbers for loop
        for var a in 0...n.count  {
            print("Hello Sensehack" , a)
            a = a * 5 + 1
            print(" a * 5 + 1 = " , a)
        }
        
        //different for array numbers for loop
        for var b in n  {
            print("Hello Sensehack" , b)
            b = b * 5 + 1
            print(" b * 5 + 1 = " , b)
        }
        
        n.remove(at: 6)
        n.append(294)
        print("//////////////////////")
        //different for array numbers for loop
        for var b in n  {
            print("Hello Sensehack" , b)
            b = b * 5 + 1
            print(" b * 5 + 1 = " , b)
        }
        */

        let animation = Int(arc4random_uniform(15) + 1)
        
//        for _ in 0...animation {
//            print("Hello Kautilya", animation)
//            //calling function
//            randomLabelPosition(person: animation)
//        }
        randomLabelPosition(person: animation)
        
//        let delaySeconds = 2.0
//        DispatchQueue.main.asyncAfter(deadline: .now() + delaySeconds) {
//            self.randomLabelPosition()
//        }

        
    }
    
    
    
    
    func randomLabelPosition (person: Int) {
        print("person random number" , person)
        for _ in 0...person {
        // setting random x & y values
        let xRandom = Int(arc4random_uniform(700) + 1)
        let yRandom = Int(arc4random_uniform(400) + 1)
        
        
//        let delaySeconds = 2.0
//        DispatchQueue.main.asyncAfter(deadline: .now() + delaySeconds) {
//            //setting the button x & y axis
//            self.helloButton.frame.origin.y = CGFloat(xRandom)
//            self.helloButton.frame.origin.x = CGFloat(yRandom)
//        }
        
//        DispatchQueue.main.async {
            //setting the button x & y axis
            self.helloButton.frame.origin.y = CGFloat(xRandom)
            self.helloButton.frame.origin.x = CGFloat(yRandom)
//        }
        
        
        print("After Explicit setting Axis", helloButton.frame.origin.y , helloButton.frame.origin.x)
        
        }
    }
    
    
    
}
