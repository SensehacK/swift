//
//  TodoItemModel.swift
//  SwiftUIBetterTodo
//
//  Created by Kautilya Save on 4/14/23.
//

import Foundation

struct Todo: Identifiable {
    let id = UUID().uuidString
    let title: String
    let isCompleted: Bool
}
