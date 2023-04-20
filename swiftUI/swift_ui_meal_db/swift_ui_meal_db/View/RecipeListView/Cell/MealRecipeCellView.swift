//
//  MealRecipeCellView.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import Foundation
import SwiftUI

struct MealRecipeCellView: View {
    
    let meal: MealViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            
            AsyncImage(url: meal.image) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(Constants.cornerRadius)
            } placeholder: {
                ProgressView()
            }
            
            Text(meal.title)
                .font(.headline)
                .fontWeight(.semibold)

        }
    }
    
    
}



struct MealRecipeCellView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyMeal: Meal = Meal(strMeal: "Apam balik", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "53049")
        let mealData = MealViewModel(meal: dummyMeal)
        MealRecipeCellView(meal: mealData)
    }
}
