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
        MealRecipeListView(recipes: Constants.dummyRecipes)
    }
}
