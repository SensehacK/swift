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
                VStack(spacing: 20) {
                    
                    // Recipe Title & Info View
                    ExtractedView(model: model, recipe: recipe)

                    // Video + Description View
                    VideoDescriptionView(recipe: recipe)
                    
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

struct ExternalLinks: View {
    let recipe: [String: String?]
    
    
    var body: some View {
        VStack(spacing: 12) {
            if let recipeVideoStr = (recipe[MealDetailKey.strYoutube.rawValue] ?? ""),
               let recipeVideo = URL(string: recipeVideoStr) {
                HeroButton(title: Constants.videoRecipeButtonText , url: recipeVideo)
            }
            
            if let sourceURLStr = (recipe[MealDetailKey.strSource.rawValue] ?? ""),
               let recipeSource = URL(string: sourceURLStr) {
                HeroButton(title: Constants.readRecipeButtonText ,
                           url: recipeSource,
                           color: Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)),
                           textColor: .gray
                )
            }
        }
    }
}

struct VideoDescriptionView: View {
    let recipe: [String: String?]
    
    var body: some View {
        VStack(spacing: 12) {
            if let imageURL =  (recipe[MealDetailKey.strMealThumb.rawValue] ?? "") {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(12)
                    
                } placeholder: {
                    ProgressView()
                }
            }
            
            Text((recipe[MealDetailKey.strInstructions.rawValue] ?? "") ?? "")
                .lineLimit(4)
            
            Text((recipe[MealDetailKey.strDrinkAlternate.rawValue] ?? "") ?? "")
        }
    }
}

struct ExtractedView: View {
    let model: MealRecipeDetailViewModel
    let recipe: [String: String?]
    
    var body: some View {
        VStack (spacing: 12) {
            Text((recipe[MealDetailKey.strMeal.rawValue] ?? "") ?? "")
                .font(.title)
            
            HStack {
                Text((recipe[MealDetailKey.strCategory.rawValue] ?? "") ?? "")
                    .font(.subheadline)
                Text("|")
                Text((recipe[MealDetailKey.strArea.rawValue] ?? "") ?? "")
                    .font(.subheadline)
            }
            
            if model.recipeMeal.tags.isNotEmpty {
                HStack {
                    ForEach(model.recipeMeal.tags.prefix(3), id: \.self) { tag in
                        Label(tag, systemImage: Constants.tagImage)
                    }
                }
            }
        }
    }
}
