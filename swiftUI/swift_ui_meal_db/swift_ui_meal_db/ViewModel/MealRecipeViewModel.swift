//
//  MealRecipeViewModel.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import Foundation


@MainActor
class MealRecipeViewModel: ObservableObject {
    
    /// Contains all the meal recipes
    @Published var meals: [MealViewModel] = []
    
    /// Fetches the recipes from `mealDB` API creating consumable [MealViewModel] data
    func fetchRecipes() async {
        
        do {
            let recipes = try await AsyncNetwork.shared.fetchData(url: Constants.API.mealURL, type: MealModel.self)
            
            meals = recipes
                .meals
                .map { MealViewModel(meal: $0) }

        } catch {
            print(error)
        }
        
    }

}


/// Consumable ViewModel
struct MealViewModel: Identifiable {
    
    fileprivate let meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    var id: String {
        meal.idMeal
    }
    
    var title: String {
        meal.strMeal
    }
    
    var image: URL? {
        URL(string:meal.strMealThumb)
    }
}
