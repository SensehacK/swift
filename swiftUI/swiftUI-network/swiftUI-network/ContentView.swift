//
//  ContentView.swift
//  swiftUI-network
//
//  Created by Kautilya Save on 4/14/23.
//

import SwiftUI
import swift_sense
import Combine

struct TODO: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let completed: Bool
}

struct ContentView: View {
    // State
    @State var todoList: [TODO] = []
    @State var quotesList: [Quote] = []
    
    @State private var presentAlert = false
    @State private var alertMessage = ""
    
    // View
    var body: some View {
        return NavigationView {
            VStack {
                List(todoList) { todo in
                    Text(todo.title)
                }
            }
            .navigationTitle(Constants.title)
            .onAppear(perform: makeNetworkRequest)
            .alert("Title", isPresented: $presentAlert, actions: {
                Button("Cancel", role: .cancel, action: {})
            }, message: {
                Text(alertMessage)
            })
        }
        
        func makeNetworkRequest() {
            
            guard let url = URL(string: Constants.factsURL) else {
                print("Not able to create URL!")
                return
            }
            Webservice().fetch(url: url) { data -> [TODO]? in
                do {
                    return try JSONDecoder().decode([TODO].self, from: data)
                } catch {
                    alertMessage = Constants.errorBadDecodingMessage
                    presentAlert.toggle()
                    return nil
                }
            } completion: { result in
                switch result {
                case .success(let todos):
                    guard let todosU = todos else { return }
                    DispatchQueue.main.async {
                        self.todoList = todosU
                    }
                case .failure(let error):
                    switch error {
                    case .requestBad:
                        alertMessage = Constants.errorRequestBadMessage
                    case .requestDataFailed:
                        alertMessage = Constants.errorRequestDecodingFailedMessage
                    }
                    presentAlert.toggle()
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
    static let title = "API TODO list "
    static let errorRequestDecodingFailedMessage = "Error while decoding network response."
    static let errorRequestBadMessage = "Bad network endpoint. Error while reaching network url!"
    static let errorBadDecodingMessage = "Error while decoding network response. Change in network endpoint contract!"
    
}
