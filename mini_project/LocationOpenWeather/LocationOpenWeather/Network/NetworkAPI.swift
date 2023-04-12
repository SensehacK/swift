//
//  NetworkAPI.swift
//  LocationOpenWeather
//
//  Created by Sensehack on 3/8/21.
//

import Foundation


// Connecting with API, making a network request and populating the object to variable response.

class NetworkAPI {
    
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> NetworkAPI {
        struct Singleton {
            static var sharedInstance = NetworkAPI()
        }
        return Singleton.sharedInstance
    }
    
    typealias Handler<OpenWeatherModel> = (Result<OpenWeatherModel, Error>) -> Void
    
    func getWeatherDataByLatLon(latitudeWeather : Double, longitudeWeather : Double, completionHandler : @escaping Handler<OpenWeatherModel>) {
        
        guard let url = URL(string: AppConstants.baseURL + Constants.lat.rawValue + String(latitudeWeather) + Constants.long.rawValue + String(longitudeWeather) + AppConstants.apiHeader + AppConstants.apiKey + Constants.units.rawValue
        ) else { return }
        
        // Creating URL Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return completionHandler(.failure(error!)) }
            
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(OpenWeatherModel.self, from: data)
                completionHandler(.success(response))
            } catch let error {
                print("Error in retrieving data" + error.localizedDescription)
            }
        }

        // Resume Asynchronous network call
        task.resume()
        
        
    }
}
