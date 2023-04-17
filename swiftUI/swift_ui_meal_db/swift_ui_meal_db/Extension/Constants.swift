//
//  Constants.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import Foundation


struct Constants {
    static let mealAPIURL: String = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    static let recipeAPIURL: String = "https://themealdb.com/api/json/v1/1/lookup.php?i="
}


// Extension Syntactic Sugar
extension Collection {
    var isNotEmpty: Bool { !isEmpty }
}
