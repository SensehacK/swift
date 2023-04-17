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
            return ["":""]
        }
        return detailedMeal
    }
    
    var recipeMeal: RecipeViewModel {
        guard let detailedMeal = meals.first else {
            return RecipeViewModel(detail: ["":""])
        }
        return detailedMeal
    }
    
    
    /// Fetches the recipes from `mealDB` API creating consumable [RecipeViewModel] data
    func fetchRecipe(id: String) async {
        
        do {
            guard let idInt = Int(id) else { return }
            let mealDetail = try await AsyncNetwork.shared.fetchData(url: Constants.API.recipeURL, id: idInt, type: MealDetail.self)
            
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

    var tags: [String] {
        let noTags = ["No Tags"]
        
        if let tagStr = detail[MealDetailKey.strTags.rawValue] {
            let tags = tagStr?.components(separatedBy: ",").shuffled() ?? noTags
            return tags
        } else {
            return noTags
        }
    }
    
    var ingredients: [String] {
        var ingredients: [String] = []
        
        for no in 1...12 {
            let keyIngr = MealDetailKey.strIngredient.rawValue + "\(no)"
            let ingrValue = (detail[keyIngr] ?? "") ?? ""
            ingredients.append(ingrValue)
        }
        return ingredients
    }

}



