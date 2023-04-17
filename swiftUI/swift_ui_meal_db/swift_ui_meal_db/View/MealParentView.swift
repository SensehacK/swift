//
//  MealParentView.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import Foundation
import SwiftUI

struct MealParentView: View {
    
    @StateObject var model: MealRecipeViewModel = MealRecipeViewModel()
    
    var body: some View {
        NavigationView {
            MealRecipeListView(recipes: model.meals)
                .task {
                    await model.fetchRecipes()
                }
                .navigationTitle(Constants.title)
        }
        
    }
}

struct MealParentView_Previews: PreviewProvider {
    static var previews: some View {
        MealParentView()
    }
}
