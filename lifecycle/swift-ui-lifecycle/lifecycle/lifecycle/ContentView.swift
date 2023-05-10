//
//  ContentView.swift
//  lifecycle
//
//  Created by Kautilya Save on 5/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var dataFetched: String
    @State var navigateToView: Bool = false
    
    @StateObject var vm = viewModel()
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    Spacer()
                    Text(dataFetched)
                    Text("Network Response ^")
                    
                    Button(action: {
                        print("Button pressed")
                    }) {
                        Text("Press ME")
                    }
                    Spacer()
                    NavigationLink(destination: AnotherView()) {
                        Text("Navigate")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .frame(width: 300.0, height: 50.0)
                            .background(Color.blue)
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            print("on Appear!!")
        }
        .onDisappear {
            print("Disappear called")
        }
        .task {
            dataFetched = await vm.fetchData()
        }
        .task(id: vm.message) {
            if !vm.message.isEmpty {
                print("Do something after you receive a response from Network")
                print(vm.message)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dataFetched: "Hello")
    }
}

@MainActor
class viewModel: ObservableObject {
    
    @Published var message: String = ""
    
    func fetchData() async -> String {
        print("Fetching Data")
        
        let (data, _) = try! await URLSession.shared.data(from: URL(string: "https://dummyjson.com/http/200")!)
        
        //        guard let data else { return "Error" }
        
        let httpResult = try? JSONDecoder().decode(http200.self, from: data)
        message = httpResult?.message ?? "NA"
        return httpResult?.status ?? "Kautilya"
    }
    
    
}


struct http200: Decodable {
    let status: String
    let message: String
}


struct AnotherView: View {
    
    var body: some View {
        VStack {
            Text("AnotherView!")
        }
        .onAppear {
            print("AnotherView on Appear!!")
        }
        .onDisappear {
            print("AnotherView Disappear called")
        }
    }
}
