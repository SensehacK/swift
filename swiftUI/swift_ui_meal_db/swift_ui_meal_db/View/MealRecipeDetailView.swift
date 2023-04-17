//
//  MealRecipeDetailView.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import Foundation
import SwiftUI

struct MealRecipeDetailView: View {
    
    let recipeMealID: Int
    
    @StateObject var model: MealRecipeDetailViewModel = MealRecipeDetailViewModel()
    
    //    let recipeMealDict: [String: String?]
    
    var body: some View {
        
        VStack {
            if model.firstMeal.isNotEmpty {
                let recipe = model.firstMeal
                VStack {
                    Text((recipe[MealDetailKey.strArea.rawValue] ?? "") ?? "Empty")
                    Text((recipe[MealDetailKey.strCategory.rawValue] ?? "") ?? "Another Wrong")
                    Text((recipe[MealDetailKey.strMeal.rawValue] ?? "") ?? "Another Wrong")
                    Text((recipe[MealDetailKey.strDrinkAlternate.rawValue] ?? "") ?? "")
                }
                
            } else {
                Text("Nothing to display")
                    .font(.title)
            }
        }
        .task {
            await model.fetchRecipe(id: recipeMealID)
        }
    }
    
}



struct MealRecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //        let noMealData: [String: String?] = [MealDetailKey.strArea.rawValue: "Empty"]
        MealRecipeDetailView(recipeMealID: 52858)
//        MealRecipeDetailView(recipeMealID: 52859)
        
        //        switch MealDetail.from(localJSON: "MealRecipe") {
        //           case .success(let value):
        //            let jsonRecipe = value.meals.first ?? noMealData
        //            MealRecipeDetailView(recipeMealID: 52858, recipeMealDict: jsonRecipe)
        //           case .failure(_):
        //               let mealData: [String: String?] = [MealDetailKey.strArea.rawValue: "Hello Kaya2"]
        //            MealRecipeDetailView(recipeMealID: 52900, recipeMealDict: mealData)
        //           }
    }
}
