//
//  MealRecipeListView.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import Foundation
import SwiftUI

struct MealRecipeListView: View {

    let recipes: [MealViewModel]
    
    
    
    var body: some View {
        List(recipes) { recipe in
            NavigationLink(destination: MealRecipeDetailView(recipeMealID: recipe.id)) {
                MealRecipeCellView(meal: recipe)
            }
           
        }
    }
    
    
}



struct MealRecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyRecipes: [MealViewModel] = [
            MealViewModel(meal: Meal(strMeal: "Apam balik", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "53049")),
            MealViewModel(meal: Meal(strMeal: "Apple & Blackberry Crumble", strMealThumb: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg", idMeal: "52768")),
            MealViewModel(meal: Meal(strMeal: "Bakewell tart", strMealThumb: "https://www.themealdb.com/images/media/meals/wyrqqq1468233628.jpg", idMeal: "52767")),
        ]
        
        MealRecipeListView(recipes: dummyRecipes)
    }
}
