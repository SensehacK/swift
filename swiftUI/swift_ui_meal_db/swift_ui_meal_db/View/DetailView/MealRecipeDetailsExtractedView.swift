//
//  MealRecipeDetailsExtractedView.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import SwiftUI

// MARK: - Extracted Views

struct RecipeTitleView: View {
    let recipe: RecipeViewModel
    
    var body: some View {
        
        
        
        VStack (spacing: 12) {
            Text(recipe.strMeal)
                .font(.title)
            
            HStack {
                Text(recipe.strCategory)
                    .font(.subheadline)
                Text("|")
                Text(recipe.strArea)
                    .font(.subheadline)
            }
            
            if recipe.tags.isNotEmpty {
                HStack {
                    ForEach(recipe.tags, id: \.self) { tag in
                        Label(tag, systemImage: MealDetailsConstants.tagImage)
                    }
                }
            }
        }
    }
}

struct ExternalLinks: View {
    let recipe: RecipeViewModel
    
    
    var body: some View {
        VStack(spacing: 12) {
            if let recipeVideo = URL(string: recipe.strYoutube) {
                HeroButton(title: MealDetailsConstants.videoRecipeButtonText , url: recipeVideo)
            }
            
            if let recipeSource = URL(string: recipe.strSource) {
                HeroButton(title: MealDetailsConstants.readRecipeButtonText ,
                           url: recipeSource,
                           color: Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)),
                           textColor: .gray
                )
            }
        }
    }
}

struct VideoDescriptionView: View {
    let recipe: RecipeViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            
                AsyncImage(url: URL(string: recipe.detail.strMealThumb)) { image in
                    image
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(Constants.cornerRadius)
                    
                } placeholder: {
                    ProgressView()
                }
            
            Text(recipe.strInstructions)
            Text(recipe.strDrinkAlternate)
        }
    }
}


struct IngredientsView: View {
    let recipe: RecipeViewModel
    let gridItems = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        VStack {
            
            Text(MealDetailsConstants.ingredients)
                .font(.headline)
            
            LazyVGrid(columns: gridItems, alignment: .center) {
                ForEach(recipe.ingredients, id: \.self) { tag in
                    Text(tag).id(UUID().uuidString)
                }
            }
        }
    }
}



struct MealDetailsConstants {
    static let lineLimit: Int = 4
    static let tagImage: String = "tag.fill"
    static let ingredients: String = "Ingredients"
    static let videoRecipeButtonText: String = "Watch it on YouTube!"
    static let readRecipeButtonText: String = "Read the full recipe!"
    static let noDataDisplayText: String = "Nothing to display, Please Try again later!"
}
