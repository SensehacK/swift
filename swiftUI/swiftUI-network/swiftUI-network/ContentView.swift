//
//  ContentView.swift
//  swiftUI-network
//
//  Created by Kautilya Save on 4/14/23.
//

import SwiftUI
import swift_sense

struct TODO: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let completed: Bool
}


struct ContentView: View {
    
    
    @State var todoList: [TODO] = []
    
    
    var body: some View {
        
        
        VStack {
            Text("Hello")
            List(todoList) { todo in
                Text(todo.title)
            }
            
        }
        .onAppear {
            
            guard let url = URL(string: Constants.factsURL) else {
                print("Not able to create URL!")
                return
            }
            Webservice().fetch(url: url) { data in
                return try! JSONDecoder().decode([TODO].self, from: data)
            } completion: { result in
                switch result {
                    
                case .success(let todos):
                    guard let todos = todos else { return }
                    DispatchQueue.main.async {
                        self.todoList = todos
                    }

                case .failure(let error):
                    print("Error \(error)")
                }
            }

            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Constants {
    static let factsURL: String = "https://jsonplaceholder.typicode.com/todos"
}
