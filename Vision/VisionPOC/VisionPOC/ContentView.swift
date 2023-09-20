//
//  ContentView.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/19/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @StateObject var viewModel: TraktViewModel = TraktViewModel()
    @State var viewDidLoad: Bool = false
    
    
    var body: some View {
        VStack {
            if let movies = viewModel.movies {
                Text("See this data ???")
                Text(movies.firstMovieName ?? "No Movie damn!")
            }
            Text("Hello Sensehack!")
        }
        .navigationTitle("Content")
//        .onAppear {
//            Task {
//            if !viewDidLoad {
//                print("HASE on Appear")
//                await viewModel.fetchData()
//                viewDidLoad = true
//                }
//            }
//        }
        .task {
            print("AHGAG23")
            if !viewDidLoad {
                print("HASE")
                await viewModel.fetchData()
                viewDidLoad = true
            }
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
