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
            if let recipe = model.recipeMeal {

                VStack {
                    // Recipe Title & Info View
                    RecipeTitleView(recipe: recipe)

                    // Video + Description View
                    VideoDescriptionView(recipe: recipe)
                    
                    // Ingredients View
                    IngredientsView(recipe: recipe)
                    
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
