//
//  TodoListViewModel.swift
//  SwiftUIBetterTodo
//
//  Created by Kautilya Save on 4/14/23.
//

import Foundation
// CRUD
class TodoListViewModel: ObservableObject {
    
    @Published var items: [Todo] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemKey = "items_key"
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard let data = UserDefaults.standard.data(forKey: itemKey),
              let decodedData = try? JSONDecoder().decode([Todo].self, from: data) else {
            return getDummyData()
        }
        
        items.append(contentsOf: decodedData)
    }
    
    func getDummyData() {
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
    
    
    func saveItems() {
        // Convert Struct to JSON
        // Store in UserDefaults in JSON
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemKey)
        }
        
        

    }
}
