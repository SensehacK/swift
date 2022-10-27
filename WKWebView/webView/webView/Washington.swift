//
//  Washington.swift
//  webView
//
//  Created by Kautilya Save on 10/27/22.
//

import Foundation

struct Washington: Decodable {
    let dateUpdated: String
    let elevationInFeet: Int
    let latitude, longitude: Double
    let mountainPassID: Int
    let mountainPassName: String
    let restrictionOne, restrictionTwo: Restriction
    let roadCondition: String
    let temperatureInFahrenheit: Int
    let travelAdvisoryActive: Bool
    let weatherCondition: String
    
    enum CodingKeys: String, CodingKey {
        case dateUpdated = "DateUpdated"
        case elevationInFeet = "ElevationInFeet"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case mountainPassID = "MountainPassId"
        case mountainPassName = "MountainPassName"
        case restrictionOne = "RestrictionOne"
        case restrictionTwo = "RestrictionTwo"
        case roadCondition = "RoadCondition"
        case temperatureInFahrenheit = "TemperatureInFahrenheit"
        case travelAdvisoryActive = "TravelAdvisoryActive"
        case weatherCondition = "WeatherCondition"
    }
    
    
}

// MARK: - Restriction
struct Restriction: Codable {
    let restrictionText, travelDirection: String
    
    enum CodingKeys: String, CodingKey {
        case restrictionText = "RestrictionText"
        case travelDirection = "TravelDirection"
    }
}



