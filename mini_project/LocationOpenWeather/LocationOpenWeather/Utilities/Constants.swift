//
//  Constants.swift
//  LocationOpenWeather
//
//  Created by Sensehack on 3/8/21.
//

import Foundation

// MARK: App Constants Enumerations
enum Constants: String {
    // App Links strings
    case lat = "?lat="
    case long = "?lon="
    case units = "imperial"
    case detailsViewSegue = "detailWeather"
}

enum HTTPStatusCode: Int {
    case statusSuccess = 200
    case statusUnauthorized = 401
}

enum Connection: String {
    case errorConnecting = "Error connecting the network"
    case statusUnavailable = "The resource is unavailable"
    case statusPermission = "The permission is denied"
    case statusUnauthorized = "The request is Unauthorized"
    case statusGateway = "Internal error occured. Bad gateway"
}

struct AppConstants {
    // App Settings
    static var apiHeader = ""
    static var apiKey = ""
    static var baseURL = ""
}



class LaunchControl {
    
    func retrieveKeys() {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            
            let keys = NSDictionary(contentsOfFile: path)
            if let apiKey:String = keys?["apiKey"] as? String {
                AppConstants.apiKey = apiKey
            }
            if let apiHeader:String = keys?["apiHeader"] as? String {
                AppConstants.apiHeader = apiHeader
            }
            if let baseURL:String = keys?["baseURL"] as? String {
                AppConstants.baseURL = baseURL
            }
       }
    }
}
