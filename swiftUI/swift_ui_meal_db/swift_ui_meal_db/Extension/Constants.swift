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
    
    static let title: String = "Dessert 🍩"
    static let ingredients: String = "Ingredients"
    static let videoRecipeButtonText: String = "Watch it on YouTube!"
    static let readRecipeButtonText: String = "Read the full recipe!"
    static let noDataDisplayText: String = "Nothing to display, Please Try again later!"

    struct FakeData {
        static let dummyRecipes: [MealViewModel] = [
            MealViewModel(meal: Meal(strMeal: "Apam balik", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "53049")),
            MealViewModel(meal: Meal(strMeal: "Apple & Blackberry Crumble", strMealThumb: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg", idMeal: "52768")),
            MealViewModel(meal: Meal(strMeal: "Bakewell tart", strMealThumb: "https://www.themealdb.com/images/media/meals/wyrqqq1468233628.jpg", idMeal: "52767")),
        ]
        
        static let dummyMeal: Meal = Meal(strMeal: "Apam balik", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "53049")
    }
    
    struct UI {
        static let cornerRadius: CGFloat = 12
        static let lineLimit: Int = 4
        static let tagImage: String = "tag.fill"
    }
    
    enum DummyRecipeID: String {
        case success = "52990"
        case failure = "2312"
    }
    
}


// Extension Syntactic Sugar
extension Collection {
    var isNotEmpty: Bool { !isEmpty }
}
