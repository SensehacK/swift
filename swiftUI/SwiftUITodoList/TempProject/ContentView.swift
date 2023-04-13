//
//  ContentView.swift
//  TempProject
//
//  Created by Kautilya Save on 4/12/23.
//

import SwiftUI


//  TODO model
struct Todo: Identifiable {
    let id: Int
    let name: String
    let isCompleted: Bool
}

struct ContentView: View {
    
    @State var textInput: String = "default"
    @State var todoCounter: Int = 6
    @State var todoData: [Todo] = [
        Todo(id: 0, name: "Hello", isCompleted: false),
        Todo(id: 1, name: "33Hello", isCompleted: false),
        Todo(id: 2, name: "GetResults", isCompleted: false),
        Todo(id: 3, name: "Hel24", isCompleted: false),
        Todo(id: 4, name: "H353", isCompleted: true),
        Todo(id: 5, name: "Helaa3t3a", isCompleted: false),
    ]
    
    
    var body: some View {

        NavigationStack {

            VStack {
                List {
                    ForEach(todoData) { todo in
                        Text(todo.name)
                            .onTapGesture {
                                print(todo.id)
                                if let currentIndex = self.todoData.firstIndex(where: { $0.id == todo.id }) {
                                    self.todoData.remove(at: currentIndex)
                                } else {
                                    print("No item to Delete!!!!")
                                }
                                
                            }
                    }
                }
                
                
                TextField("", text: $textInput)
                Spacer()
                Button {
                    addTodo()
                } label: {
                    Image(systemName: "plus")
                }

            }
            

        }
    }
    

    func addTodo(isCompleted: Bool = false) {
        todoData.append(Todo(id: todoCounter, name: textInput, isCompleted: isCompleted))
        todoCounter += 1
        textInput = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
