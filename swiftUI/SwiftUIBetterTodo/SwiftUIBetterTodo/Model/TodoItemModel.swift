//
//  TodoItemModel.swift
//  SwiftUIBetterTodo
//
//  Created by Kautilya Save on 4/14/23.
//

import Foundation

struct Todo: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    
    init(id: String = UUID().uuidString,
         title: String,
         isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> Todo {
        return Todo(id: id , title: title, isCompleted: !isCompleted)
    }
}
