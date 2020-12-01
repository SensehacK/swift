//
//  CityTableViewController.swift
//  OpenWeatherApi
//
//  Created by Kautilya on 13/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController {
    
    var temper : Double = 0
    var cityName : String   = ""
    var pressure : Int = 0
    var humidity : Int = 0
    var lat : Double = 0
    var lon : Double = 0

    var coreWeather : [CityWeather] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var selectedRow : CityWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCoreData()
        
        tableView.reloadData()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCoreData()
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(coreWeather.count)
        return coreWeather.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityNamesCell", for: indexPath)
        
        let weatherObj = coreWeather[indexPath.row]
        print(weatherObj.cityName!)
        cell.textLabel?.text = weatherObj.cityName
        cell.detailTextLabel?.text = String(weatherObj.cityTemp)
        
        
        // Configure the cell...
        
        return cell
    }
    
    @IBAction func networkButton(_ sender: Any) {
        print("network button pressed")
        
        getNetworkData()
        
        print("///////////////////////////")
        print("///////////////////////////")
        print("///////////////////////////")
        print("///////////////////////////")
        print("getNetworkData")
        print("///////////////////////////")
        print("///////////////////////////")
        print("///////////////////////////")
        print("///////////////////////////")
//        saveToCoreData()
        print("///////////////////////////")
        print("///////////////////////////")
        print("///////////////////////////")
        print("///////////////////////////")
        print("Mysore Saved")
        print("///////////////////////////")
        print("///////////////////////////")
    }
    
    
    
    
    // http://api.openweathermap.org/data/2.5/weather?q=Mysore,india&appid=6dae697b64c9d7a3eec3887426b454dd
    
    
    
    
    func getNetworkData () {
        
        let urlString = "http://api.openweathermap.org/data/2.5/weather?q=Mysore,india&appid=6dae697b64c9d7a3eec3887426b454dd"
        
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
                self.tableView.reloadData()
                
            }
            catch let error as NSError {
                print("error catched")
                print(error)
            }
        }
    task.resume()
        
        
    }
    
    
    
    func saveToCoreData() {
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
    
    func getCoreData () {
        
        do {
           coreWeather =  try appDelegate.persistentContainer.viewContext.fetch(CityWeather.fetchRequest())
            print("Core data retrieved")
        }catch {
            print("Error")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedCity = coreWeather[indexPath.row]
        selectedRow = coreWeather[indexPath.row]
        print("selectedrow")
        print(selectedRow!)
        
        performSegue(withIdentifier: "showCitySegue", sender: nil)
        
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let managedContext = appDelegate.persistentContainer.viewContext
            let objectSelected = coreWeather[indexPath.row]
            managedContext.delete(objectSelected)
            
            appDelegate.saveContext()
            
            getCoreData()
            tableView.reloadData()
        }
        
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showCitySegue" {
            print("In segues")
            
            let displayVC = segue.destination as! CityDisplayViewController
            print("Hello")
            displayVC.segueCity  = selectedRow
            
        }
    }
   

}

extension UIViewController {
    func showAlert(title : String , message: String) {
        let alertDisplay = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let pressOK = UIAlertAction(title: "OK", style: .default){
            _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertDisplay.addAction(pressOK)
        present(alertDisplay, animated: true, completion: nil)
    }
    

    
}
