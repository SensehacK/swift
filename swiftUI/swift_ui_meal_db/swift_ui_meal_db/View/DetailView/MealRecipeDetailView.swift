//
//  MealRecipeDetailView.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import Foundation
import SwiftUI

struct MealRecipeDetailView: View {
    
    let recipeMealID: String
    
    @StateObject var model: MealRecipeDetailViewModel = MealRecipeDetailViewModel()
    
    var body: some View {
        
        VStack {
            if model.firstMeal.isNotEmpty {
                let recipe = model.firstMeal
                VStack {
                    
                    // Recipe Title & Info View
                    RecipeTitleView(model: model, recipe: recipe)

                    // Video + Description View
                    VideoDescriptionView(recipe: recipe)
                    
                    // Ingredients View
                    IngredientsView(model: model)
                    
                    // External Links
                    ExternalLinks(recipe: recipe)
                }
                .padding(20)
                
            } else {
                Text(Constants.noDataDisplayText)
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
        
        MealRecipeDetailView(recipeMealID: Constants.DummyRecipeID.success.rawValue) // Success screen
        // MealRecipeDetailView(recipeMealID: Constants.DummyRecipeID.failure.rawValue) // Error Screen
        
    }
}
