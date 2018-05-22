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
    
    var countries = [CountryStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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


}

