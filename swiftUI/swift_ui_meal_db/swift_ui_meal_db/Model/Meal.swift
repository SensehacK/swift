//
//  Meal.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import Foundation

// MARK: - Root Model
struct MealModel: Decodable {
    let meals: [Meal]
}

// MARK: - Meal
struct Meal: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
