//
//  SwiftUIBetterTodoApp.swift
//  SwiftUIBetterTodo
//
//  Created by Kautilya Save on 4/14/23.
//

import SwiftUI

@main
struct SwiftUIBetterTodoApp: App {
    
    @StateObject var listViewModel: TodoListViewModel = TodoListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
