//
//  Constants.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import Foundation


struct Constants {
    
    struct API {
        static let mealURL: String = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        static let recipeURL: String = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    }
    
    
    static let tagImage: String = "tag.fill"
    static let videoRecipeButtonText: String = "Watch it on YouTube!"
    static let readRecipeButtonText: String = "Read the full recipe!"
    static let noDataDisplayText: String = "Nothing to display, Please Try again later!"
    
    
    enum DummyRecipeID: String {
        case success = "52858"
        case failure = "2312"
    }
}


// Extension Syntactic Sugar
extension Collection {
    var isNotEmpty: Bool { !isEmpty }
}
