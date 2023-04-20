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
        
//        VStack {
//            if model.firstMeal.isNotEmpty {
//                let recipe = model.firstMeal
//                VStack {
//
//                    // Recipe Title & Info View
//                    RecipeTitleView(model: model, recipe: recipe)
//
//                    // Video + Description View
//                    VideoDescriptionView(recipe: recipe)
//
//                    // Ingredients View
//                    IngredientsView(model: model)
//
//                    // External Links
//                    ExternalLinks(recipe: recipe)
//                }
//                .padding(20)
//
//            } else {
//                Text(Constants.noDataDisplayText)
//                    .font(.title)
//            }
//        }
//        .task {
//            await model.fetchRecipe(id: recipeMealID)
//        }
        
        VStack {
            if let recipe = model.recipeMeal2 {
//                let recipe = model.firstMeal2
                VStack {
                    
//                    // Recipe Title & Info View
                    RecipeTitleView2(recipe: recipe)

                    // Video + Description View
                    VideoDescriptionView2(recipe: recipe)
                    
                    // Ingredients View
                    IngredientsView2(recipe: recipe)
                    
                    // External Links
                    ExternalLinks2(recipe: recipe)
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



struct RecipeTitleView2: View {
    let recipe: RecipeViewModel2
    
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
                    ForEach(recipe.tags.prefix(3), id: \.self) { tag in
                        Label(tag, systemImage: Constants.UI.tagImage)
                    }
                }
            }
        }
    }
}

struct ExternalLinks2: View {
    let recipe: RecipeViewModel2
    
    
    var body: some View {
        VStack(spacing: 12) {
            if let recipeVideo = URL(string: recipe.strYoutube) {
                HeroButton(title: Constants.videoRecipeButtonText , url: recipeVideo)
            }
            
            if let recipeSource = URL(string: recipe.strSource) {
                HeroButton(title: Constants.readRecipeButtonText ,
                           url: recipeSource,
                           color: Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)),
                           textColor: .gray
                )
            }
        }
    }
}

struct VideoDescriptionView2: View {
    let recipe: RecipeViewModel2
    
    var body: some View {
        VStack(spacing: 12) {
            if let imageURL = recipe.detail.strMealThumb {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(Constants.UI.cornerRadius)
                    
                } placeholder: {
                    ProgressView()
                }
            }
            
            Text(recipe.strInstructions)
                .lineLimit(Constants.UI.lineLimit)

            Text(recipe.strDrinkAlternate)
        }
    }
}


struct IngredientsView2: View {
    let recipe: RecipeViewModel2
    let gridItems = [
        GridItem(.adaptive(minimum: 60))
    ]
    
    var body: some View {
        VStack {
            
            Text(Constants.ingredients)
                .font(.headline)
            
            LazyVGrid(columns: gridItems, alignment: .center) {
                ForEach(recipe.ingredients, id: \.self) { tag in
                    Text(tag).id(UUID().uuidString)
                }
            }
        }
    }
}
