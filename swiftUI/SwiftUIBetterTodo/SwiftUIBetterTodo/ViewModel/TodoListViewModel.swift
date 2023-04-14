//
//  TodoListViewModel.swift
//  SwiftUIBetterTodo
//
//  Created by Kautilya Save on 4/14/23.
//

import Foundation
// CRUD
class TodoListViewModel: ObservableObject {
    
    @Published var items: [Todo] = []
    
    
    init() {
        getItems()
    }
    
    func getItems() {
        let listData: [Todo] = [
            Todo(title: "First", isCompleted: false),
            Todo(title: "2", isCompleted: true),
            Todo(title: "Fi2rst", isCompleted: false),
            Todo(title: "Fir33435st", isCompleted: false)
        ]
        
        items.append(contentsOf: listData)
    }
    
    func addItem(todo: String) {
        let todoItem = Todo(title: todo, isCompleted: false)
        items.append(todoItem)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }

    func completeItem(todo: Todo) {
        guard let todoIndex = (items.firstIndex { $0.id == todo.id }) else { return }
        items[todoIndex] = todo.updateCompletion()
    }

    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
}
