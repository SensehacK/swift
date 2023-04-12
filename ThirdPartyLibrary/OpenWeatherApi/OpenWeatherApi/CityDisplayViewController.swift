//
//  CityDisplayViewController.swift
//  OpenWeatherApi
//
//  Created by Kautilya on 13/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class CityDisplayViewController: UIViewController {

    
    
    
    var segueCity  : CityWeather?
    
    @IBOutlet var cityL: UILabel!
    
    @IBOutlet var tempL: UILabel!
    
    @IBOutlet var humL: UILabel!
    
    
    @IBOutlet var windL: UILabel!
    
    @IBOutlet var geoL: UILabel!
    
    @IBOutlet var maxMinL: UILabel!
    
    @IBAction func backBP(_ sender: Any) {
        
        
        
//        _ = navigationController?.popViewController(animated: true)
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello")
        
        // set the labels accordingly
        
        cityL.text = "City  : \(segueCity?.cityName!)"
        tempL.text = "Temperature  : \(segueCity?.cityTemp)"
        humL.text = "Humidity  : \(segueCity?.humidity)"
        windL.text  = "Wind  : 2Kmph "
        geoL.text  = "Geo Coordinates Lat : \(segueCity?.lat)  & Lon :\(segueCity?.lon) "
        maxMinL.text = "Pressure : \(segueCity?.pressure) "
        
    }

    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("In view will appear")
        
    }
    
    
    
    


}
