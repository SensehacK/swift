//
//  MealRecipeDetailViewModel.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import Foundation


@MainActor
class MealRecipeDetailViewModel: ObservableObject {
    
    /// Contains all the meal recipes
    @Published var meals: [RecipeViewModel] = []
    
    var firstMeal: [String: String?] {
        guard let detailedMeal = meals.first?.detail else {
            return ["": ""]
        }
        return detailedMeal
    }
    
    /// Fetches the recipes from `mealDB` API creating consumable [RecipeViewModel] data
    func fetchRecipe(id: Int) async {
        
        do {
            let mealDetail = try await AsyncNetwork.shared.fetchData(url: Constants.recipeAPIURL, id: id, type: MealDetail.self)
            
            meals = mealDetail
                .meals
                .map { RecipeViewModel(detail: $0) }
        } catch {
            print(error)
        }
        
    }

}


/// Consumable ViewModel
struct RecipeViewModel: Identifiable {
    let id = UUID().uuidString
    let detail: [String: String?]
    
    init(detail: [String: String?]) {
        self.detail = detail
    }
    
//    var id: String {
//        meal.idMeal
//    }
//
//    var title: String {
//        meal.strMeal
//    }
//
//    var image: URL? {
//        URL(string:meal.strMealThumb)
//    }
}



