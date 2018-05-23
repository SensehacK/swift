//
//  ViewController.swift
//  AlamafireTest
//
//  Created by Kautilya on 10/05/18.
//  Copyright © 2018 Kautilya. All rights reserved.
//

import UIKit
import Alamofire


struct CountryStruct : Decodable {
    let name : String
    let capital : String
}


class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var mainButton: UIButton!
    
    @IBOutlet weak var pressMeCountLabel: UILabel!
    
    
    var buttonPressedCount = 0
    var countries = [CountryStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pressMeCountLabel.text = "Button Pressed Count"
        
        let url = URL(string: "https://restcountries.eu/rest/v2/all")
        
        Alamofire.request(url!).responseJSON { (response) in
            let httpResultCode = response.result
            let resultJSON = response.data
            
            print("Alamofire Request Inside")
            print("Result returned by JSON Website" , httpResultCode)
            print("Result printed again" , resultJSON!)
            do {
                self.countries = try JSONDecoder().decode([CountryStruct].self, from: resultJSON!)
            } catch {
                print("Error")
            }
            print("All JSON Data")
            print(self.countries)
//            print(self.countries.name)
//            print(self.countries.capital)
            
            // Looping JSON Data in for loop for printing / accessing
            
            for country in self.countries {
                let countryName = country.name
                let countryCapital = country.capital
                
                print("\n Country " + countryName + "'s Capital is " + countryCapital + ".")
//                print("\n")
            }
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func pressMeBtn(_ sender: Any) {
        buttonPressedCount += 1
        print("\n Button Pressed" , buttonPressedCount)
        
        pressMeCountLabel.text = "Button Pressed " + String(buttonPressedCount)
        
        
        if buttonPressedCount > 13 && buttonPressedCount < 20 {
            print("Congrats you have no job to do")
            mainLabel.textColor = UIColor.red
            mainLabel.text = "Hello Jobless person"
        }
        else if buttonPressedCount > 20 {
            var gJob:String = "Get a JOB"
            // "For : .highlighted " doesn't change the button title text
            mainButton.setTitle(gJob.localizedUppercase, for: .normal)
//            mainButton.setTitle("JOB", for: .normal)
            print("Get a JOB")
            
        }
        let rand = Int(arc4random_uniform(251))
        print("Random number is : " ,rand)
        print("Country at 50th position: ", countries[50].name)
        
        print("Country at random position: ", countries[rand].name)
        
    }
    
    

}

