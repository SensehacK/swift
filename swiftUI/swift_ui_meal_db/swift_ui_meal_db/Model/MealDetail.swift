//
//  MealDetail.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import Foundation

// MARK: - Meal Detail
struct MealDetail: Decodable {
    let meals: [[String: String?]]
}

// MARK: - Dictionary Keys
enum MealDetailKey: String, Decodable {
    case idMeal
    case strMeal
    case strDrinkAlternate
    case strCategory
    case strArea
    case strInstructions
    case strMealThumb
    case strTags
    case strYoutube
    case strIngredient
    case strIngredient1
    case strIngredient2
    case strIngredient3
    case strIngredient4
    case strIngredient5
    case strIngredient6
    case strIngredient7
    case strIngredient8
    case strIngredient9
    case strIngredient10
    case strIngredient11
    case strIngredient12
    case strIngredient13
    case strIngredient14
    case strIngredient15
    case strIngredient16
    case strIngredient17
    case strIngredient18
    case strIngredient19
    case strIngredient20
    case strMeasure1
    case strMeasure2
    case strMeasure3
    case strMeasure4
    case strMeasure5
    case strMeasure6
    case strMeasure7
    case strMeasure8
    case strMeasure9
    case strMeasure10
    case strMeasure11
    case strMeasure12
    case strMeasure13
    case strMeasure14
    case strMeasure15
    case strMeasure16
    case strMeasure17
    case strMeasure18
    case strMeasure19
    case strMeasure20
    case strSource
    case strImageSource
    case strCreativeCommonsConfirmed
    case dateModified
}
