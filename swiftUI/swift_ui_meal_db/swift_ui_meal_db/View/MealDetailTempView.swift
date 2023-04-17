
//
//  MealDetailTempView..swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import Foundation
import SwiftUI

struct MealDetailTempView: View {
    
    
    let recipe: MealDetail
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 10) {
            if let mealDetails = recipe.meals.first {
                Text((mealDetails[MealDetailKey.strMeal.rawValue] ?? "Empty") ?? "Another Wrong")
                    .font(.title)
                
                
                Text((mealDetails[MealDetailKey.strArea.rawValue] ?? "Empty") ?? "Another Wrong")
                
                Text((mealDetails[MealDetailKey.strInstructions.rawValue] ?? "Empty") ?? "No Instructions")
                    .lineLimit(4)
                
                
            } else {
                Text("No Value")
            }
            
        }
        .padding(.horizontal)
        
    }
    
    
    
}


struct MealDetailTempView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        
        switch MealDetail.from(localJSON: "MealRecipe") {
        case .success(let value):
            let jsonRecipe = value
            MealDetailTempView(recipe: jsonRecipe)
        case .failure(_):
            let mealData: [String: String?] = [MealDetailKey.strArea.rawValue: "Hello Kaya2"]
            let dummyRecipe2: MealDetail = MealDetail(meals: [mealData])
            
            // New
            //            let mealDetailD = [MealDetailKey.strArea.rawValue: "Hello K222"]
            //            let mealData: MealDetailDict = MealDetailDict(detail: mealDetailD)
            //
            //            //            [MealDetailKey.strArea.rawValue: "Hello Kaya2"]
            //            let dummyRecipe2: MealDetail = MealDetail(meals: [mealData])
            
            MealDetailTempView(recipe: dummyRecipe2)
        }
        
        
        
        
        
        
    }
}
