//
//  DisplayViewController.swift
//  OpenWeatherApi
//
//  Created by Kautilya on 13/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {
    
    
    var temper : Double = 0
    var cityName : String   = ""
    var pressure : Int = 0
    var humidity : Int = 0
    var lat : Double = 0
    var lon : Double = 0
    
    var weatherObj : CityWeather?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var cityLabe: UILabel!
    @IBOutlet var tempLabe: UILabel!
    
    @IBOutlet var humidityLabe: UILabel!
    
    @IBOutlet var windLabe: UILabel!
    
    @IBOutlet var geoLabe: UILabel!
    
    @IBOutlet var minMaxLabe: UILabel!
    
    @IBOutlet var backB: UIButton!
    @IBOutlet var cityTF: UITextField!
    
    @IBOutlet var searchB: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func backBPressed(_ sender: Any) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }

    @IBAction func searchBPressed(_ sender: Any) {
        print("search button PRessed")
        networkData()
        print("///////////////////////////")
        print("///////////////////////////")
        print("///////////////////////////")
        print("///////////////////////////")
        print("Back from network")
        saveToCoreData()
        print("///////////////////////////")
        print("///////////////////////////")
        print("///////////////////////////")
        print("///////////////////////////")
        print("City Saved")
        print("///////////////////////////")
        print("///////////////////////////")
//        let cityName = cityTF.text

            
        

        
        
        _=navigationController?.popViewController(animated: true)
    }


    
    func networkData () {
        var urlString = "http://api.openweathermap.org/data/2.5/weather?q=Mysore,india&appid=6dae697b64c9d7a3eec3887426b454dd"
        print("/////////////////////////////////////////////////////////////v//////////////////////////////////////////////////")
        print(urlString)
        
        if let cityName = cityTF.text {
            urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName),india&appid=6dae697b64c9d7a3eec3887426b454dd"
            
        }
        
        
        print("/////////////////////////////////////////////////////////////v//////////////////////////////////////////////////")
        print(urlString)
        
        print("/////////////////////////////////////////////////////////////v//////////////////////////////////////////////////")
        let url = URL(string: urlString)
        
        print(url as Any)
        let task = URLSession.shared.dataTask(with: url!) { (data, response , error) in
            
            print("In dataTask")
            
            var parsedOpenWeatherData : NSDictionary!
            
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
                parsedOpenWeatherData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                
                
                print("Dictionary")
                
                print("///////////////////////////")
                print(parsedOpenWeatherData)
                
                guard let jsonCityName = parsedOpenWeatherData?["name"] as? String else {
                    
                    print("error in guard Statement while getting Name")
                    return
                    
                }
                
                // Debug Prints
                print("OpenWeatherConstants.WeatherData.City = jsonCityName")
                print(jsonCityName)
                
                
                
                // Dictionary parsing in Dictionary
                guard let jsonMain = parsedOpenWeatherData["main"] as? NSDictionary else {
                    
                    print("error in guard Statement while getting Main Array Dictionary JSON")
                    return
                    
                }
                
                // JSON Main Branch data Handling.
                
                guard var jsonMainTemp = jsonMain["temp"] as? Double else {
                    
                    print("error in guard Statement while getting Main Temp")
                    return
                    
                }
                
                jsonMainTemp = jsonMainTemp/10
                
                //Debug Print
                print("Temperature")
                print(jsonMainTemp)
                
                
                guard let coordDict = parsedOpenWeatherData["coord"] as? NSDictionary else {
                    self.showAlert(title: "Error getting Coordinates", message: "Error")
                    return
                }
                
                print(coordDict)
                
                guard let lat = coordDict["lon"] as? Double else {
                    return
                }
                
                print("SESFSAFSFAWFAWFWFWASFSAFFWAWFWAAAWFW")
                print("Latitude")
                print(String(lat))
                self.lat = lat
                guard let lon  = coordDict["lat"] as? Double else {
                    return
                }
                
                print("SESFSAFSFAWFAWFWFWASFSAFFWAWFWAAAWFW")
                print("Longitude")
                print(String(lon))
                self.lon = lon
                
                
                guard let pressure2 = jsonMain["pressure"] as? Int else {
                    print("Error in pressure")
                    return
                }
                //Debug Print
                print("pressure")
                print(pressure2)
                
                guard let humidity2 = jsonMain["humidity"] as? Int else {
                    print("Error in pressure")
                    return
                }
                //Debug Print
                print("humidity")
                print(humidity2)
                
                
                
                
                // if big array of dictionary
                
                guard let jsonWeather = parsedOpenWeatherData["weather"] as? [[String : Any]] else {
                    
                    print("error in guard Statement while getting weather Array Dictionary JSON")
                    return
                    
                }
                
                var weatherToday : String!
                var weatherDescription : String!
                
                for data in jsonWeather  {
                    
                    // JSON objects parameters Response Result : Reference "weather":[{"id":711,"main":"Smoke","description":"smoke","icon":"50d"}]
                    
                    
                    guard let weatherTodayData = data["main"] as? String else {
                        
                        print("error in guard Statement while getting Main Min Temp")
                        return
                        
                    }
                    weatherToday = weatherTodayData
                    
                    
                    guard let weatherDescriptionData = data["description"] as? String else {
                        
                        print("error in guard Statement while getting Main Min Temp")
                        return
                        
                    }
                    weatherDescription = weatherDescriptionData
                    
                    print(weatherToday)
                    print(weatherDescription)
                    
                    
                    // Setting the values to class variables
                    self.temper = jsonMainTemp
                    self.cityName = jsonCityName
                    self.pressure = pressure2
                    self.humidity = humidity2
                } // End data traversal in Array of String  : Any
                
                self.saveToCoreData()
                
                _=self.navigationController?.popViewController(animated: true)
            }
            catch let error as NSError {
                print("error catched")
                print(error)
            }
        }
        task.resume()
        
    }
    func saveToCoreData () {
        print("Ecord data ")
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let cityWeatherObj = CityWeather(context: managedContext)
        
        cityWeatherObj.cityName = cityName
        cityWeatherObj.cityTemp = temper
        cityWeatherObj.humidity = Int16(humidity)
        cityWeatherObj.lat = lat
        cityWeatherObj.lon = lon
        cityWeatherObj.pressure = Int16(pressure)
        appDelegate.saveContext()
        
        print("saved to core Data")
        
    }
    
    
}
