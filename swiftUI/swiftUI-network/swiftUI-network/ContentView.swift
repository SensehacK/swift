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


struct Quotes: Decodable {
    let quotes: [Quote]
    let total: Int
}


struct Quote: Identifiable, Decodable, Hashable {
    let id: Int
    let quote: String
    let author: String
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
            
            makeAsyncRequest()
            
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
        
        
        
        func makeAsyncRequest() {
            var cancellables = Set<AnyCancellable>()

            AsyncNetwork.shared.getData(url: "https://dummyjson.com/quotes", type: Quotes.self)
                .sink { completion in
                    print("Error failure")
                    switch completion {
                    case .failure(let error):
                        print(error)
                    case .finished:
                        print("Finish")
                    }
                }
                receiveValue: { quotesData in
                    print("Got the data!")
        //            print(quotesData.)
                    print(quotesData)
                    
                }
                .store(in: &cancellables)
            }
        
    }
}


struct QuotesView: View {
    
    @ObservedObject var viewModel = QuotesVM()
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.quotes, id: \.self) { value in
                            Text(value.quote)
                                .padding()
                            
                            VStack(alignment: .trailing) {
                                Text("-\(value.author)")
                                    
                            }
                            .padding(.horizontal, 36)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                                .background(Color.yellow)
                        }
                    }
                }
                .navigationTitle("Quotes")
            }
            
        }.onAppear {
            viewModel.getHomeData()
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
        QuotesView()
    }
}


struct Constants {
    static let factsURL: String = "https://jsonplaceholder.typicode.com/todos"
    static let title = "API TODO list "
    static let errorRequestDecodingFailedMessage = "Error while decoding network response."
    static let errorRequestBadMessage = "Bad network endpoint. Error while reaching network url!"
    static let errorBadDecodingMessage = "Error while decoding network response. Change in network endpoint contract!"
    
}
