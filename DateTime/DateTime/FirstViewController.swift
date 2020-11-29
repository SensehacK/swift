//
//  FirstViewController.swift
//  DateTime
//
//  Created by Kautilya on 09/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var sliderFirstVC: UISlider!
    @IBOutlet var segmentFirstVC: UISegmentedControl!
    
    @IBOutlet var firstLabel: UILabel!
    
    @IBOutlet var smallLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateObj = Date()
        let calendar = Calendar.current
        print("type(of : dateObj)")
        print(type(of : dateObj))
        print(dateObj)
        
        
        let hour      = calendar.component(.hour, from : dateObj)
        let minutes   = calendar.component(.minute, from: dateObj)
        let seconds   = calendar.component(.second, from: dateObj)
        let nanosec   = calendar.component(.nanosecond, from: dateObj)
        
        let ever = calendar.component(.quarter, from: dateObj)
        print(ever)
        print("SesfWE:")
        
        print("Current time is : \(hour) : \(minutes) : \(seconds) ")
        print("Nanoseconds : \(nanosec)")
        
        let day      = calendar.component(.day, from : dateObj)
        let month   = calendar.component(.month, from: dateObj)
        let year   = calendar.component(.year, from: dateObj)
        
        let weekOfMonth = calendar.component(.weekOfMonth, from: dateObj)
        
        print("Current time is : Day \(day) : Month \(month) : Year \(year) ")
        
        print("Week of the month : \(weekOfMonth)")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func segmentSelected(_ sender: Any) {
        let selectedIndex = segmentFirstVC.selectedSegmentIndex
        
        if selectedIndex == 0 {
            firstLabel.text = "Hello SensehacK"
        }
        else if selectedIndex == 1 {
            smallLabel.text = "Hello Cruel World"
        }
        
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let sliderValue : String = String(Int(sender.value))
        
        firstLabel.text = sliderValue
        
    }
    
    
    

}

