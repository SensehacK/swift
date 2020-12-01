//
//  CurrencyApiViewController.swift
//  OpenWeatherApi
//
//  Created by Kautilya on 13/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit
import Foundation

class CurrencyApiViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {

    
    
    @IBOutlet var numtextf: UITextField!
    
    @IBOutlet var numTF2: UITextField!
    
    
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var convert: UIButton!
    
    var currencyRate : [Double] = []
    var currencyCountry :[String] = []
    var selectedCountry : Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNetworkData()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for index in currencyCountry {
            print("afnajangjjnjabwjfjawnjnwjn")
            print(index)
        }
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print(currencyCountry.count)
        return currencyCountry.count
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print(currencyCountry[row])
        return currencyCountry[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = Double(currencyRate[row])
    }
    
    
    
    
    @IBAction func convertButPre(_ sender: Any) {
        let convertedCur = selectedCountry * Double(numtextf.text!)!
        
        priceLabel.text  = String(convertedCur)
        
        
        
    }
    
    
    func getNetworkData () {
        
        let urlString = "http://api.fixer.io/latest"
        
        let url = URL(string: urlString)
        
        print(url as Any)
        let task = URLSession.shared.dataTask(with: url!) { (data, response , error) in
            
            print("In dataTask")
            
            var parsedOpenApiData : NSDictionary!
            
            guard let data = data else {
                print("Data not present,")
                //Debug print
                self.showAlert(title: "Data not present" , message: "Error in func getWeatherDataByCity data not present Guard Statement")
                return
            }
            
            guard error == nil else {
                print("error present")
                //Debug print
                self.showAlert(title: "error present" , message: "Error in func getWeatherDataByCity Guard Statement")
                return
            }
            
            // Status code msgs
            guard let statusCodes = (response as? HTTPURLResponse)?.statusCode , statusCodes >= 200 && statusCodes <= 600 else {
                print("Wrong status codes")
                self.showAlert(title: "Server not present" , message: "Wrong status codes returned func getWeatherDataByCity")
                return
            }
            
            
            do {
                parsedOpenApiData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                
                
                print("Dictionary")
                
                print("///////////////////////////")
                print(parsedOpenApiData)
                
                if let jsoncurr = parsedOpenApiData?["rates"] as? NSDictionary
                {
                    print("In ns dictionary")
                    
                    for (country , currency) in jsoncurr {
                        self.currencyCountry.append(country as! String)
                        self.currencyRate.append(currency as! Double)
                    }
                    
                    for (country , currency) in jsoncurr {
                        print(country)
                        print(currency)
                    }
                    
                    
                    // Dictionary parsing in Dictionary
                    guard let jsoncurrencyRate = jsoncurr["USD"] as? Double else {
                        
                        print("error in guard Statement while getting Main Array Dictionary JSON")
                        return
                    }
                    print(jsoncurrencyRate)
                    
                }
                print("Task Ends")
                self.pickerView.reloadAllComponents()
        
                } // End data traversal in Array of String  : Any
                catch let error as NSError {
                    print("error catched")
                    print(error)
                }
            
            }
        task.resume()
        
        
        
        }

}

