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
    @Published var meals2: [RecipeViewModel2] = []
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
    
    var recipeMeal2: RecipeViewModel2? {
        guard let detailedMeal = meals2.first else {
            return nil
        }
        return detailedMeal
    }
    
    
    /// Fetches the recipes from `mealDB` API creating consumable [RecipeViewModel] data
    func fetchRecipe(id: String) async {
        
        do {
            guard let idInt = Int(id) else { return }
//            let mealDetail = try await AsyncNetwork.shared.fetchData(url: Constants.API.recipeURL, id: idInt, type: MealDetail.self)
            //            meals = mealDetail
            //                .meals
            //                .map { RecipeViewModel(detail: $0) }
            
            
            
            let mealDetail2 = try await AsyncNetwork.shared.fetchData(url: Constants.API.recipeURL, id: idInt, type: MealDetail2.self)
            

            
            
            meals2 = mealDetail2
                .meals
                .map({ data in
//                    print(data.strCategory)
                    let returnedData = RecipeViewModel2(detail: data)
                    return returnedData
                })
            
            
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
            if ingrValue.count > 0 {
                ingredients.append(ingrValue)
            }
        }
        return ingredients
    }

}





struct RecipeViewModel2: Identifiable {
    let id = UUID().uuidString
    let detail: MealDetail2Key
    
    init(detail: MealDetail2Key) {
        self.detail = detail
    }
    
    var strIngredient: String {
        detail.strIngredient1 ?? "nil"
    }
    
    var ingredients: [String] {
        [
            strIngredient1,
            strIngredient2,
            strIngredient3,
            strIngredient4,
            strIngredient5,
            strIngredient6,
            strIngredient7,
            strIngredient8,
            strIngredient9,
            strIngredient10,
            strIngredient11,
            strIngredient12,
            strIngredient13,
            strIngredient14,
            strIngredient15,
            strIngredient16,
            strIngredient17,
            strIngredient18,
            strIngredient19,
            strIngredient20
        ]
    }
    
    var tags: [String] {
        return detail.strTags?.components(separatedBy: ",").shuffled() ?? [""]
    }

    var idMeal: String {
        return detail.idMeal ?? ""
    }
    var strMeal: String {
        return detail.strMeal ?? ""
    }
    var strDrinkAlternate: String {
        return detail.strDrinkAlternate ?? ""
    }
    var strCategory: String {
        return detail.strCategory ?? ""
    }
    var strArea: String {
        return detail.strArea ?? ""
    }
    var strInstructions: String {
        return detail.strInstructions ?? ""
    }
    var strMealThumb: String {
        return detail.strMealThumb ?? ""
    }
    var strTags: String {
        return detail.strTags ?? ""
    }
    var strYoutube: String {
        return detail.strYoutube ?? ""
    }
    var strIngredient1: String {
        return detail.strIngredient1 ?? ""
    }
    var strIngredient2: String {
        return detail.strIngredient2 ?? ""
    }
    var strIngredient3: String {
        return detail.strIngredient3 ?? ""
    }
    var strIngredient4: String {
        return detail.strIngredient4 ?? ""
    }
    var strIngredient5: String {
        return detail.strIngredient5 ?? ""
    }
    var strIngredient6: String {
        return detail.strIngredient6 ?? ""
    }
    var strIngredient7: String {
        return detail.strIngredient7 ?? ""
    }
    var strIngredient8: String {
        return detail.strIngredient8 ?? ""
    }
    var strIngredient9: String {
        return detail.strIngredient9 ?? ""
    }
    var strIngredient10: String {
        return detail.strIngredient10 ?? ""
    }
    var strIngredient11: String {
        return detail.strIngredient11 ?? ""
    }
    var strIngredient12: String {
        return detail.strIngredient12 ?? ""
    }
    var strIngredient13: String {
        return detail.strIngredient13 ?? ""
    }
    var strIngredient14: String {
        return detail.strIngredient14 ?? ""
    }
    var strIngredient15: String {
        return detail.strIngredient15 ?? ""
    }
    var strIngredient16: String {
        return detail.strIngredient16 ?? ""
    }
    var strIngredient17: String {
        return detail.strIngredient17 ?? ""
    }
    var strIngredient18: String {
        return detail.strIngredient18 ?? ""
    }
    var strIngredient19: String {
        return detail.strIngredient19 ?? ""
    }
    var strIngredient20: String {
        return detail.strIngredient20 ?? ""
    }
    var strMeasure1: String {
        return detail.strMeasure1 ?? ""
    }
    var strMeasure2: String {
        return detail.strMeasure2 ?? ""
    }
    var strMeasure3: String {
        return detail.strMeasure3 ?? ""
    }
    var strMeasure4: String {
        return detail.strMeasure4 ?? ""
    }
    var strMeasure5: String {
        return detail.strMeasure5 ?? ""
    }
    var strMeasure6: String {
        return detail.strMeasure6 ?? ""
    }
    var strMeasure7: String {
        return detail.strMeasure7 ?? ""
    }
    var strMeasure8: String {
        return detail.strMeasure8 ?? ""
    }
    var strMeasure9: String {
        return detail.strMeasure9 ?? ""
    }
    var strMeasure10: String {
        return detail.strMeasure10 ?? ""
    }
    var strMeasure11: String {
        return detail.strMeasure11 ?? ""
    }
    var strMeasure12: String {
        return detail.strMeasure12 ?? ""
    }
    var strMeasure13: String {
        return detail.strMeasure13 ?? ""
    }
    var strMeasure14: String {
        return detail.strMeasure14 ?? ""
    }
    var strMeasure15: String {
        return detail.strMeasure15 ?? ""
    }
    var strMeasure16: String {
        return detail.strMeasure16 ?? ""
    }
    var strMeasure17: String {
        return detail.strMeasure17 ?? ""
    }
    var strMeasure18: String {
        return detail.strMeasure18 ?? ""
    }
    var strMeasure19: String {
        return detail.strMeasure19 ?? ""
    }
    var strMeasure20: String {
        return detail.strMeasure20 ?? ""
    }
    var strSource: String {
        return detail.strSource ?? ""
    }
    var strImageSource: String {
        return detail.strImageSource ?? ""
    }
    var strCreativeCommonsConfirmed: String {
        return detail.strCreativeCommonsConfirmed ?? ""
    }
    var dateModified: String {
        return detail.dateModified ?? ""
    }
    
    

}
