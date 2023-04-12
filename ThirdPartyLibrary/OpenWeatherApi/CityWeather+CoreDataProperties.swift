//
//  CityWeather+CoreDataProperties.swift
//  OpenWeatherApi
//
//  Created by Kautilya on 13/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import Foundation
import CoreData


extension CityWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityWeather> {
        return NSFetchRequest<CityWeather>(entityName: "CityWeather");
    }

    @NSManaged public var pressure: Int16
    @NSManaged public var lon: Double
    @NSManaged public var lat: Double
    @NSManaged public var cityName: String?
    @NSManaged public var cityTemp: Double
    @NSManaged public var humidity: Int16

}
