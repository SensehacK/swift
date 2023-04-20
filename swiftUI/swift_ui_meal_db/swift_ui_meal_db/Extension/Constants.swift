//
//  Constants.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import Foundation


struct Constants {
    
    static let title: String = "Dessert 🍩"
    static let cornerRadius: CGFloat = 12
    
    struct API {
        static let mealURL: String = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        static let recipeURL: String = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    }
    
    static let dummyRecipes: [MealViewModel] = [
        MealViewModel(meal: Meal(strMeal: "Apam balik", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "53049")),
        MealViewModel(meal: Meal(strMeal: "Apple & Blackberry Crumble", strMealThumb: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg", idMeal: "52768")),
        MealViewModel(meal: Meal(strMeal: "Bakewell tart", strMealThumb: "https://www.themealdb.com/images/media/meals/wyrqqq1468233628.jpg", idMeal: "52767")),
    ]

}


// Extension Syntactic Sugar
extension Collection {
    var isNotEmpty: Bool { !isEmpty }
}
