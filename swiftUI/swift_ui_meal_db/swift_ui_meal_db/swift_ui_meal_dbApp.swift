//
//  swift_ui_meal_dbApp.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import SwiftUI

@main
struct swift_ui_meal_dbApp: App {
    var body: some Scene {
        WindowGroup {
//            MealParentView()
            
            MealRecipeDetailView(recipeMealID: 52858)
         }
    }
}
