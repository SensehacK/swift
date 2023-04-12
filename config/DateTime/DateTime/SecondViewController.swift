//
//  SecondViewController.swift
//  DateTime
//
//  Created by Kautilya on 09/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    
    @IBOutlet var datePickerView: UIDatePicker!
    
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        datePickerView.datePickerMode = .date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let selectedDate = dateFormatter.string(from: datePickerView.date)
        print(selectedDate)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func DatePickerAction(_ sender: Any) {
        print("Hello Cruel World")
        secondLabel.text = "Hello Kautilya Save"
        
        
        datePickerView.datePickerMode = .date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let selectedDate = dateFormatter.string(from: datePickerView.date)
        
        print("func Action Print Date")
        print(selectedDate)
        
        firstLabel.text = selectedDate
        
        
        let uiDatePicker = datePickerView.date
        print("uiDatePicker")
        print(uiDatePicker)
        let date1 = Date()
        let date2 = Date().addingTimeInterval(100)
        
        print("date1")
        print(date1)
        
        print("date2")
        print(date2)
        
        if date1 == date2
        {
            print("Equal")
        }
        else if date1 > date2
        {
            print("Date 1 is greater than Date 2")
        }
        else if date1 < date2
        {
             print("Date 2 is greater than Date 1")
        }
        else if uiDatePicker > date1 {
            print("User Date picked is greater than today")
            print("New Deal")
        }
        
        else if uiDatePicker < date1 {
            print("User Date picked is smaller than today")
            print("Old deal")
        }
        
        
        
        if uiDatePicker > date1 {
            print("User Date picked is greater than today")
            print("New Deal")
        }
            
        else if uiDatePicker < date1 {
            print("User Date picked is smaller than today")
            print("Old deal")
        }

        
        
    }
    
    
    

}

