//
//  MealRecipeDetailsExtractedView.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import SwiftUI

// MARK: - Extracted Views

struct RecipeTitleView: View {
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
                        Label(tag, systemImage: Constants.UI.tagImage)
                    }
                }
            }
        }
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
                        .cornerRadius(Constants.UI.cornerRadius)
                    
                } placeholder: {
                    ProgressView()
                }
            }
            
            Text((recipe[MealDetailKey.strInstructions.rawValue] ?? "") ?? "")
                .lineLimit(Constants.UI.lineLimit)
            
            Text((recipe[MealDetailKey.strDrinkAlternate.rawValue] ?? "") ?? "")
        }
    }
}


struct IngredientsView: View {
    let model: MealRecipeDetailViewModel
    let gridItems = [
        GridItem(.adaptive(minimum: 60))
    ]
    
    var body: some View {
        VStack {
            
            Text(Constants.ingredients)
                .font(.headline)
            
            
            LazyVGrid(columns: gridItems, alignment: .center) {
                ForEach(model.recipeMeal.ingredients, id: \.self) { tag in
                    Text(tag)
                    
                }
            }
        }
    }
}
